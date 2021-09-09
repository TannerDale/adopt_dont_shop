class DogPicturesController < ApplicationController
  def index
    if params[:breed]
      breed = params[:breed]
      @picture = DogPictureFacade.get_a_picture(breed)
    end
    @all_breeds = DogBreed.all_formatted
  end
end
