require 'rails_helper'

RSpec.describe DogBreed, type: :model do
  let!(:breed1) { DogBreed.create(name: 'dane/great') }
  let!(:breed2) { DogBreed.create(name: 'husky') }
  let!(:breed3) { DogBreed.create(name: 'shepherd/australian') }
  let!(:breed4) { DogBreed.create(name: 'bulldog/boston') }

  it 'can format a name for a form' do
    expect(breed1.formatted_name).to eq(['Great Dane', 'dane/great'])
    expect(breed2.formatted_name).to eq(['Husky', 'husky'])
  end

  it 'can format all names for the form' do
    expect(DogBreed.all_formatted).to eq([['Great Dane', 'dane/great'], ['Husky', 'husky'], ['Australian Shepherd', 'shepherd/australian'], ['Boston Bulldog', 'bulldog/boston']])
  end
end
