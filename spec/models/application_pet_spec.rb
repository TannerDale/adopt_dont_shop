require 'rails_helper'

RSpec.describe ApplicationPet, type: :model do
  it { should belong_to :pet }
  it { should belong_to :application }

  describe 'methods' do
    before :each do
      @app = Application.create!(name: 'A', address: 'a', city: 'a', state: 'a', zipcode: 'a')
      @shelter = Shelter.create!(name: 'a', foster_program: true, rank: 10000000, city: 'a')
      @pet = Pet.create!(name: 'Rifle', age: '11', breed: 'terrier', adoptable: true, shelter_id: @shelter.id)

      @app_pet = ApplicationPet.create!(application_id: @app.id, pet_id: @pet.id)
    end

    it 'has an approval of false by default' do
      expect(@app_pet.approved).to be(false)
    end
  end
end
