class Shelter < ApplicationRecord
  validates :name, presence: true
  validates :rank, presence: true, numericality: true
  validates :city, presence: true

  has_many :pets, dependent: :destroy

  def self.order_by_recently_created
    order(created_at: :desc)
  end

  def self.order_by_number_of_pets
    select("shelters.*, count(pets.id) AS pets_count")
      .joins("LEFT OUTER JOIN pets ON pets.shelter_id = shelters.id")
      .group("shelters.id")
      .order("pets_count DESC")
  end

  def pet_count
    pets.count
  end

  def adoptable_pets
    pets.where(adoptable: true)
  end

  def number_adoptable
    adoptable_pets.length
  end

  def alphabetical_pets
    adoptable_pets.order(name: :asc)
  end

  def shelter_pets_filtered_by_age(age_filter)
    adoptable_pets.where('age >= ?', age_filter)
  end

  scope :reverse_alphabetical, -> {
    Shelter.find_by_sql(
      "SELECT shelters.* FROM shelters ORDER BY shelters.name DESC"
    )
  }

  scope :pending_applications, -> {
    Shelter.joins(pets: :applications).where('applications.status = ?', 1)
    .distinct.order(:name)
  }

  def formatted_info
    info = shelter_info.first
    "#{info[:name]} - #{info[:city]}"
  end

  def shelter_info
    Shelter.find_by_sql [
      'SELECT shelters.name, shelters.city FROM shelters WHERE shelters.id = ?', self.id
    ]
  end

  def average_adoptable_age
    pets.where(adoptable: true).average(:age)
  end

  def adopted_pets_count
    pets.joins(:applications)
    .where('applications.status = ? AND pets.adoptable = ?', 2, false)
    .count('pets.id')
  end

  def action_required
    pets.joins(:applications).where('applications.status = ?', 1)
  end
end
