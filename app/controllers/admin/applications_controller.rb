class Admin::ApplicationsController < ApplicationController
  before_action :current_application, :check_if_approved
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

  def check_if_approved
    @application.check_if_approved
  end
end
