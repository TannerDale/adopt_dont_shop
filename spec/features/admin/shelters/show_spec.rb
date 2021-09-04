require 'rails_helper'

RSpec.describe 'admin shelter show page' do
  before :each do
    @shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    visit admin_shelter_path(@shelter)
  end

  it 'has its formatted name and address' do
    expect(page).to have_content('Aurora shelter - Aurora, CO')
  end
end
