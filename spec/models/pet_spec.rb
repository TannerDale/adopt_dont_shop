require 'rails_helper'

RSpec.describe Pet, type: :model do
  describe 'relationships' do
    it { should belong_to(:shelter) }
    it { should have_many :application_pets }
    it { should have_many(:applications).through(:application_pets) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:age) }
    it { should validate_numericality_of(:age) }
  end

  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 3, adoptable: false)
  end

  describe 'class methods' do
    describe '#search' do
      it 'returns partial matches' do
        expect(Pet.search("Claw")).to eq([@pet_2])
      end
    end

    describe '#search_for' do
      it 'returns partial matches' do
        expect(Pet.search_for("A")).to eq([@pet_1, @pet_2])
      end
    end

    describe '#adoptable' do
      it 'returns adoptable pets' do
        expect(Pet.adoptable).to eq([@pet_1, @pet_2])
      end
    end
  end

  describe 'instance methods' do
    describe '.shelter_name' do
      it 'returns the shelter name for the given pet' do
        expect(@pet_3.shelter_name).to eq(@shelter_1.name)
      end
    end

    describe 'updating pets for an approved application' do
      before :each do
        @application = Application.create(
          name: 'Tanner',
          address: '12345',
          city: 'city',
          state: 'state',
          zipcode: '12345'
        )
        @application2 = Application.create(
          name: 'Brynn',
          address: '12345',
          city: 'city',
          state: 'state',
          zipcode: '12345'
        )
        @application.pets << @pet_1
        @application.pets << @pet_2
        @application2.pets << @pet_1
        @application2.pets << @pet_2
      end

      describe '.update_pets' do
        it 'can make pets not adoptable if it is on an approved applcation' do
          @application.update_attribute(:status, 2)
          Pet.update_pets!(@application)

          [@pet_1, @pet_2].each do |pet|
            expect(pet.reload.adoptable).to be(false)
          end
        end
      end

      describe '.pending_applications' do
        it 'has all of its pending applications' do
          @application.update_attribute(:status, 1)
          @application2.update_attribute(:status, 1)

          expect(@pet_1.pending_applications).to eq([@application, @application2])

          @application2.update_attribute(:status, 2)

          expect(@pet_1.pending_applications).to eq([@application])
        end
      end
    end
  end
end
