class DogPicturesController < ApplicationController
  def index
    if params[:breed]
      @picture = DogPictureFacade.get_a_picture(params[:breed])
    end
    @all_breeds = DogBreed.all_formatted
  end
end
