class PetPictureService
  class << self
    def call_for_picture(breed)
      response = conn.get("/api/breed/#{breed}/images/random")
      parse_data(response)
    end

    private

    def conn
      conn = Faraday.new('https://dog.ceo')
    end

    def parse_data(response)
      data = JSON.parse(response.body, symbolize_names: true)
    end
  end
end
