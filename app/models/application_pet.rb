class ApplicationPet < ApplicationRecord
  belongs_to :application
  belongs_to :pet

  validates_uniqueness_of :pet_id, scope: :application_id

  enum status: %w(pending approved rejected)
end
