class FoxPictureFacade
  class << self
    def get_a_picture
      FoxPicture.picture(parse)
    end

    def response
      Faraday.get("https://randomfox.ca/floof/")
    end

    def parse
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end
