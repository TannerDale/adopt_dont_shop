class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  scope :search, ->(search_params) {
    where("name ILIKE ?", "%#{search_params}%")
  }
end
