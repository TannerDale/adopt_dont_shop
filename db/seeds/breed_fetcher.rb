module BreedFetcher
  extend self

  def fetch_data
    response = Faraday.get("https://dog.ceo/api/breeds/list/all")
    parse(response)
  end

  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  def formatted_breeds
    data = fetch_data[:message]
    data.each.flat_map do |main, subset|
      if subset.length > 0
        subset.map { |sub_breed| "#{main.to_s}/#{sub_breed}" }
      else
        main
      end
    end
  end
end
