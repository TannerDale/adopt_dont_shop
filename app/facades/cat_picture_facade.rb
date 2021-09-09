class CatPictureFacade
  class << self
    def get_a_picture
      data = CatPictureService.call_for_picture
      CatPicture.new(data)
    end
  end
end
