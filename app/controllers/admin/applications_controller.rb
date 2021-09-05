class Admin::ApplicationsController < ApplicationController
  before_action :current_application, :update_statuses!
  helper_method :application_pet

  def show
  end

  private

  def current_application
    @application = Application.find(params[:id])
  end

  def application_pet(pet)
    @application.find_app_pet(pet)
  end

  def update_statuses!
    @application.update_status!

    update_pets! if @application.approved?
  end

  def update_pets!
    Pet.update_pets!(@application)
  end
end
