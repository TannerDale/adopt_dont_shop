require 'rails_helper'

RSpec.describe 'applications show' do
  describe 'without pets' do
    before :each do
      @app = Application.create!(
        name: 'Tanner',
        address: '12345 Street St',
        city: 'Austin',
        state: 'Texas',
        zipcode: '12345'
      )
       visit application_path(@app.id)
    end

    it 'has the application info' do
      expect(page).to have_content(@app.name)
      expect(page).to have_content(@app.address)
      expect(page).to have_content(@app.city)
      expect(page).to have_content(@app.state)
      expect(page).to have_content(@app.zipcode)
      expect(page).to have_content('In Progress')
    end

    it 'doesnt have a submit button when no pets are added' do
      expect(page).not_to have_content('Submit Application')
    end
  end

  describe 'pet searching and adding' do
    before :each do
      @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
      @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
      @pet_3 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 3, adoptable: false)
      @app = Application.create!(
        name: 'Tanner',
        address: '12345 Street St',
        city: 'Austin',
        state: 'Texas',
        zipcode: '12345'
      )
      visit application_path(@app.id)
    end

    it 'can show matching pets' do
      fill_in 'Name', with: 'claw'
      click_on 'Find'

      expect(page).to have_content(@pet_2.name)
      expect(page).to have_content(@pet_2.breed)
      expect(page).to have_content(@pet_2.age)
    end

    it 'can add pets to an application, but only once' do
      fill_in 'Name', with: 'claw'
      click_on 'Find'

      within "div##{@pet_2.name}" do
        click_button 'Adopt this Pet'
      end

      expect(@app.pets).to include(@pet_2)

      click_on 'Find'

      within "div##{@pet_2.name}" do
        click_button 'Adopt this Pet'
      end

      expect(page).to have_content('Pet Can Only Be Added Once')
    end
  end

  describe 'submitting application' do
    before :each do
      @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
      @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
      @pet_3 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 3, adoptable: false)
      @app = Application.create!(
        name: 'Tanner',
        address: '12345 Street St',
        city: 'Austin',
        state: 'Texas',
        zipcode: '12345'
      )

      @app.pets << @pet_1
      @app.pets << @pet_2
      @app.pets << @pet_3

      visit application_path(@app.id)
    end

    it 'can submit when pets are added to application' do
      fill_in 'Why I would be a great owner.', with: 'I like pets.'
      click_button 'Submit Application'

      expect(page).to have_content('Pending')
      expect(page).not_to have_content('Find')
    end

    it 'rejects when no reason is given' do
      click_button 'Submit Application'

      expect(page).to have_content('Reason Must be Provided')
      expect(page).not_to have_content('Pending')
    end
  end
end
