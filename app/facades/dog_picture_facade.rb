class DogPictureFacade
  class << self
    def get_a_picture(breed)
       if breed == 'shibe'
        DogPicture.picture(get_shibe)
      else
        DogPicture.picture(get_by_breed(breed.downcase))
     end
    end

    private

    def get_by_breed(breed)
      data = DogPictureService.call_for_picture(breed)

      if data.has_value?('success')
        data
      else
        {message: "image_not_found.png"}
      end
    end

    def get_shibe
      data = ShibePictureService.call_for_picture
      {message: data.first}
    end
  end
end
