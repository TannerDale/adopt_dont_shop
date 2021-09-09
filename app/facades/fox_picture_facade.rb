class FoxPictureFacade
  class << self
    def get_a_picture
      data = FoxPictureService.parse
      FoxPicture.picture(data)
    end
  end
end
