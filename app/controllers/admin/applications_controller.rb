class Admin::ApplicationsController < ApplicationController
  before_action :current_application
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
end
