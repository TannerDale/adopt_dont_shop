class ApplicationPet < ApplicationRecord
  after_update :update_relations!

  belongs_to :application
  belongs_to :pet

  validates :pet_id, presence: true, numericality: true
  validates :application_id, presence: true, numericality: true
  validates_uniqueness_of :pet_id, scope: :application_id

  enum status: %w(pending approved rejected)

  private

  def update_relations!
    self.application.update_status!
    Pet.update_pets!(self.application) if self.application.approved?
  end
end
