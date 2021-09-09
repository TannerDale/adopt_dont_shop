class DogPictureFacade
  class << self
    def get_a_picture(breed)
      data = DogPictureService.call_for_picture(breed)
      if data.has_value?('success')
        DogPicture.picture(data)
      else
        DogPicture.picture({message: "image_not_found.png"})
      end
    end
  end
end
