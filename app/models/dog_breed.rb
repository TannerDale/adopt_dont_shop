class DogBreed < ApplicationRecord
  scope :all_formatted, -> {
    DogBreed.all.map(&:formatted_name)
  }

  def formatted_name
    if name.include?('/')
      [name.split('/').reverse.map(&:capitalize).join(' '), name]
    else
      [name.capitalize, name]
    end
  end
end
