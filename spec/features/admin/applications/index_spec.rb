require 'rails_helper'

RSpec.describe 'admin applications index' do
  describe 'applications' do
    let!(:shelter_1) { Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9) }
    let(:pet1) { shelter_1.pets.create!(name: 'Rifle', breed: 'terrier', age: 11, adoptable: true) }
    let(:pet2) { shelter_1.pets.create!(name: 'Snickers', breed: 'great dane', age: 13, adoptable: true) }
    let(:app1) { Application.create!(
      name: 'Tanner',
      address: '123',
      city: 'a',
      state: 'b',
      zipcode: 'a',
      reason: 'pets'
    ) }
    let(:app2) { Application.create!(
      name: 'Rennat',
      address: '123',
      city: 'a',
      state: 'b',
      zipcode: 'a',
      reason: 'pets'
    ) }

    before :each do
      app1.pets << pet1
      app1.pets << pet2
      app2.pets << pet1
      app2.pets << pet2

      visit admin_applications_path
    end

    it 'has the applications info' do
      [app1, app2].each do |app|
        expect(page).to have_content(app.name)
        expect(page).to have_content(app.status)
        expect(page).to have_content(app.address)
        expect(page).to have_content(app.city)
        expect(page).to have_content(app.state)
        expect(page).to have_content(app.reason)
      end
    end
  end
end
