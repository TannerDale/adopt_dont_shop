class FoxPictureService
  class << self
    def response
      Faraday.get("https://randomfox.ca/floof/")
    end

    def parse
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end
