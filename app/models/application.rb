class Application < ApplicationRecord
  validates :name, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zipcode, presence: true

  has_many :application_pets, dependent: :destroy
  has_many :pets, through: :application_pets

  enum status: ['In Progress', 'Pending', 'Accepted', 'Rejectd']

  def submittable?
    not_submitted? && pets.length > 0
  end

  def not_submitted?
    status == 'In Progress'
  end

  def find_app_pet(pet)
    application_pets.find_by(pet_id: pet.id).id
  end

  def app_pet(pet)
    ApplicationPet.find(find_app_pet(pet))
  end

  def check_if_approved
    update_attribute(:status, 2) if approved?
  end

  def approved?
    application_pets.where(status: 'approved') == application_pets
  end
end
