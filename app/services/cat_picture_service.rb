class CatPictureService
  class << self
    def call_for_picture
      check_for_name(parse)
    end

    private

    def response
      Faraday.get("https://api.thecatapi.com/v1/images/search?api_key=#{ENV['cat_api_key']}")
    end

    def parse
      JSON.parse(response.body, symbolize_names: true).first
    end

    def check_for_name(data)
      if data[:breeds].length > 0
        data[:name] = data[:breeds].first[:name]
        data.delete(:breeds)
      end
      data
    end
  end
end
