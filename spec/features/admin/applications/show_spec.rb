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
      @app.pets << @pet1
      @app.pets << @pet2

      visit admin_application_path(@app.id)
    end

    it 'can approve a pet' do
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
  end
end
