class Admin::ApplicationsController < ApplicationController
  before_action :current_application, :check_status
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

  def check_status
    @application.check_status

    update_pets! if @application.approved?
  end

  def update_pets!
    Pet.update_pets!(@application)
  end
end
