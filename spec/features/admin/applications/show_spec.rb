require 'rails_helper'

RSpec.describe 'admin applications show' do
  describe 'buttons for approving/rejecting pets' do
    before :each do
      @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      @pet1 = @shelter_1.pets.create!(name: 'Rifle', breed: 'terrier', age: 11, adoptable: true)
      @pet2 = @shelter_1.pets.create!(name: 'Snickers', breed: 'great dane', age: 13, adoptable: true)
      @app = Application.create!(
        name: 'Tanner',
        address: '123',
        city: 'a',
        state: 'b',
        zipcode: 'a',
        reason: 'pets'
      )
      @app2 = Application.create!(
        name: 'Rennat',
        address: '123',
        city: 'a',
        state: 'b',
        zipcode: 'a',
        reason: 'pets'
      )
      @app.pets << @pet1
      @app.pets << @pet2
      @app2.pets << @pet1
      @app2.pets << @pet2

      visit admin_application_path(@app)
    end

    it 'can approve a pet' do
      visit admin_application_path(@app.id)
      within '#Rifle-status' do
        click_button 'Approve'

        expect(current_path).to eq(admin_application_path(@app.id))

        expect(page).to have_content('Approved!')
      end
    end

    it 'can reject a pet' do
      within '#Snickers-status' do
        click_button 'Reject'

        expect(current_path).to eq(admin_application_path(@app.id))

        expect(page).to have_content('Rejected!')
      end
    end

    it 'doesnt change the status on other applications' do
      visit admin_application_path(@app2)

      within '#Snickers-status' do
        expect(page).to have_button('Reject')
        expect(page).to have_button('Approve')
      end

      within '#Rifle-status' do
        expect(page).to have_button('Reject')
        expect(page).to have_button('Approve')
      end
    end
  end

  describe 'status is updated when all pets are approved' do
    before :each do
      @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      @pet1 = @shelter_1.pets.create!(name: 'Rifle', breed: 'terrier', age: 11, adoptable: true)
      @pet2 = @shelter_1.pets.create!(name: 'Snickers', breed: 'great dane', age: 13, adoptable: true)
      @app = Application.create!(
        name: 'Tanner',
        address: '123',
        city: 'a',
        state: 'b',
        zipcode: 'a',
        reason: 'pets'
      )
      @app.pets << @pet1
      @app.pets << @pet2
      @app.update_attribute(:status, 1)

      visit admin_application_path(@app)
    end

    it 'updates status to approved when all pets are approved' do
      expect(page).to have_content('Pending')

      within '#Snickers-status' do
        click_button 'Approve'
      end

      within '#Rifle-status' do
        click_button 'Approve'
      end

      expect(page).to have_content('Accepted')
      expect(page).not_to have_content('Pending')
    end
  end
end
