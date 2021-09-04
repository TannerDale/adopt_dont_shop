class Admin::ApplicationsController < ApplicationController
  before_action :current_application

  def show
  end

  def update
    if params[:status] == 'accepted'
      @application.update_attribute(:status, 2)
    elsif params[:status] == 'rejected'
      @application.update_attribute(:status, 3)
    end
  end

  private

  def current_application
    @application = Application.find(params[:id])
  end
end
