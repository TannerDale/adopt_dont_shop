require 'rails_helper'

RSpec.describe 'admin shelter show page' do
  before :each do
    @shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    visit admin_shelter_path(@shelter)
  end

  it 'has its formatted name and address' do
    expect(page).to have_content('Aurora shelter - Aurora, CO')
  end

  describe 'statistics section' do
    it 'has a statistics section' do
      expect(page).to have_content('Statistics')
    end

    it 'has the average age of adoptable pets' do
      pet_1 = @shelter.pets.create!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
      pet_2 = @shelter.pets.create!(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
      pet_3 = @shelter.pets.create!(name: 'Ann', breed: 'ragdoll', age: 5, adoptable: true)
      visit admin_shelter_path(@shelter)

      expect(page).to have_content("The average age of adoptable pets is #{8.fdiv(2)} years old.")
    end
  end
end
