class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  belongs_to :shelter
  has_many :application_pets, dependent: :destroy
  has_many :applications, through: :application_pets

  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end

  scope :update_pets!, ->(app) {
    pets_for_application(app).update_all(adoptable: false)
  }

  scope :pets_for_application, ->(app) {
    joins(application_pets: :application)
    .where('applications.id = ? AND applications.status = ?', app.id, 2)
    .where('pets.adoptable = ?', true)
  }
end
