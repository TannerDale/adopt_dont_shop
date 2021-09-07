class ApplicationPetsController < ApplicationController
  def create
    app_pet = ApplicationPet.new(app_pet_params)
    if app_pet.save
      flash[:success] = "Pet Added"
    else
      flash[:alert] = "Pet Can Only Be Added Once"
    end

    redirect_to application_path(params[:application_id])
  end

  def update
    app_pet = ApplicationPet.find(params[:id])
    if params[:status] == '1' || params[:status] == '2'
      app_pet.update(app_pet_params.merge(status: params[:status].to_i))
    else
      flash[:danger] = 'Invalid status value!'
    end

    redirect_to admin_application_path(params[:application_id])
  end

  private

  def app_pet_params
    params.permit(:application_id, :pet_id)
  end
end
