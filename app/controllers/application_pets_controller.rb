class ApplicationPetsController < ApplicationController
  def create
    ApplicationPet.create(app_pet_params)
    flash[:success] = "Pet Added"

    redirect_to application_path(params[:application_id])
  end

  def update
    app_pet = ApplicationPet.find(params[:id])
    app_pet.update_attribute(:approved, true)

    redirect_to admin_application_path(params[:application_id])
  end

  def destroy
    app_pet = ApplicationPet.find(params[:id])
    app_pet.destroy!

    redirect_to admin_application_path(params[:application_id])
  end

  private

  def app_pet_params
    params.permit(:application_id, :pet_id)
  end
end
