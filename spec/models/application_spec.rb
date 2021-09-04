require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zipcode) }
  end

  describe 'relationships' do
    it { should have_many :application_pets }
    it { should have_many(:pets).through(:application_pets) }
  end

  describe 'status' do
    let(:status) { ['In Progress', 'Pending', 'Accepted', 'Rejectd'] }

    it 'has the right index' do
      status.each_with_index do |item, index|
        expect(Application.statuses[item]).to eq(index)
      end
    end
  end

  describe 'applications based on status' do
    it '#submitted?' do
      app = Application.create!(name: 'Test', address: '123', city: 'city', state: 'state', zipcode: '12345')

      expect(app.not_submitted?).to be(true)
      app.update_attribute(:status, 1)
      expect(app.not_submitted?).to be(false)
    end

    it '#submitable?' do
      app = Application.create!(name: 'Test', address: '123', city: 'city', state: 'state', zipcode: '12345')
      expect(app.submittable?).to be(false)

      allow(app).to receive(:pets).and_return(['pet 1', 'pet 2'])

      expect(app.submittable?).to be(true)

      app.update_attribute(:status, 2)

      expect(app.submittable?).to be(false)

      app.update_attribute(:status, 3)

      expect(app.submittable?).to be(false)
    end
  end

  describe 'validating pet status' do
    before :each do
      @app = Application.create!(name: 'A', address: 'a', city: 'a', state: 'a', zipcode: 'a')
      @shelter = Shelter.create!(name: 'a', foster_program: true, rank: 10000000, city: 'a')
      @pet = Pet.create!(name: 'Rifle', age: '11', breed: 'terrier', adoptable: true, shelter_id: @shelter.id)

      @app_pet = ApplicationPet.create!(application_id: @app.id, pet_id: @pet.id)
    end

    it '#find_app_pet' do
      expect(@app.find_app_pet(@pet)).to eq(@app_pet.id)
    end

    it '#pet_approved?' do
      expect(@app.pet_approved?(@pet)).to be(false)

      @app_pet.update_attribute(:approved, true)

      expect(@app.pet_approved?(@pet)).to be(true)
    end
  end
end
