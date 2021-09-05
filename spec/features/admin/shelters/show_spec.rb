require 'rails_helper'

RSpec.describe 'admin shelter show page' do
  before :each do
    @shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = @shelter.pets.create!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
    @pet_2 = @shelter.pets.create!(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter.pets.create!(name: 'Ann', breed: 'ragdoll', age: 5, adoptable: true)
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
      expect(page).to have_content("The average age of adoptable pets is #{8.fdiv(2)} years old.")
    end

    it 'has the number of adoptable pets' do
      app = Application.create!(
        name: 'Tanner',
        address: '123',
        city: 'a',
        state: 'b',
        zipcode: 'a',
        reason: 'pets'
      )
      app.pets << @pet_2

      app.update_attribute(:status, 1)

      visit admin_application_path(app)

      within '#Clawdia-status' do
        click_button 'Approve'
      end

      visit admin_shelter_path(@shelter)

      expect(page).to have_content("There is 1 pet available for adoption.")
    end

    describe 'stats and action requried' do
      before :each do
        @app = Application.create!(
          name: 'Tanner',
          address: '123',
          city: 'a',
          state: 'b',
          zipcode: 'a',
          reason: 'pets'
        )
        @app2 = Application.create!(
          name: 'Tanner',
          address: '123',
          city: 'a',
          state: 'b',
          zipcode: 'a',
          reason: 'pets'
        )
        @app.pets << @pet_2
        @app2.pets << @pet_3
      end

      it 'has number adopted pets' do
        visit admin_application_path(@app)
        click_button 'Approve'

        visit admin_shelter_path(@shelter)

        expect(page).to have_content('1 pets have been adopted from this shelter.')

        visit admin_application_path(@app2)
        click_button 'Approve'

        visit admin_shelter_path(@shelter)

        expect(page).to have_content('2 pets have been adopted from this shelter.')
      end

      it 'has pets with action required' do
        @app.update_attribute(:status, 1)
        @app2.update_attribute(:status, 1)

        visit admin_shelter_path(@shelter)

        expect(page).to have_content(@pet_2.name)
        expect(page).to have_content(@pet_3.name)

        @pet_2.pending_applications.each do |app|
          expect(page).to have_link(app.name)
        end
      end
    end
  end
end
