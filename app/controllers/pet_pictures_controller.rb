class PetPicturesController < ApplicationController
  def index
    if params[:breed]
      breed = params[:breed]
      @picture = PetPictureFacade.get_a_picture(breed)
    end
  end
end
