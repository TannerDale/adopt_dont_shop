class CatPicturesController < ApplicationController
  def index
    @cat = CatPictureFacade.get_a_picture
  end
end
