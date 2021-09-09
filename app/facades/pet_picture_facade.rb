class PetPictureFacade
  class << self
    def get_a_picture(breed)
      data = PetPictureService.call_for_picture(breed)

      if data.has_value?('success')
        PetPicture.picture(data)
      else
        PetPicture.picture({message: "image_not_found.png"})
      end
    end
  end
end
