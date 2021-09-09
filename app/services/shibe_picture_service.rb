class ShibePictureService
  class << self
    def call_for_picture
      JSON.parse(response.body)
    end

    private

    def response
      Faraday.get("http://shibe.online/api/shibes?count=1")
    end
  end
end
