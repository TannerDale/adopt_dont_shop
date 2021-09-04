class RemoveAppovedFromApplicationPet < ActiveRecord::Migration[5.2]
  def change
    remove_column :application_pets, :approved
  end
end
