class ApplicationsController < ApplicationController
  def show
    @application = current_application
    if params[:name]
      @pets = Pet.search_for(params[:name])
    end
  end

  def new
    @application = Application.new
  end

  def create
    new_app = Application.new(application_params)
    if new_app.save
      flash[:success] = 'Application Submitted!'
      redirect_to application_path(new_app.id)
    else
      flash[:alert] = 'Incomplete Application'
      redirect_to new_application_path
    end
  end

  def update
    app = current_application
    if params[:application][:reason].present?
      app.update!(application_params.merge({status: 1}))
    else
      flash[:alert] = 'Reason Must be Provided'
    end

    redirect_to application_path(app)
  end

  private

  def application_params
    params.require(:application).permit(:name, :address, :city, :state, :zipcode, :reason)
  end

  def current_application
    Application.find(params[:id])
  end
end
