class ApplicationPet < ApplicationRecord
  belongs_to :application
  belongs_to :pet

  enum status: %w(pending approved rejected)
end
