class FoxPicturesController < ApplicationController
  def index
    @picture = FoxPictureFacade.get_a_picture
  end
end
