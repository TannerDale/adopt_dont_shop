class Application < ApplicationRecord
  validates :name, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zipcode, presence: true

  has_many :application_pets, dependent: :destroy
  has_many :pets, through: :application_pets

  enum status: ['In Progress', 'Pending', 'Accepted', 'Rejected']

  def submittable?
    not_submitted? && pets.length > 0
  end

  def not_submitted?
    status == 'In Progress'
  end

  def app_pet(pet)
    ApplicationPet.find(find_app_pet(pet))
  end

  def find_app_pet(pet)
    application_pets.find_by(pet_id: pet.id).id
  end

  def update_status!
    update_attribute(:status, 2) if approved?
    update_attribute(:status, 3) if rejected?
  end

  def approved?
    !(application_pets.where.not(status: 'approved').exists?)
  end

  def rejected?
    application_pets.where(status: 'rejected').exists?
  end
end
