module DogBreedFetcher
  extend self

  def get_data
    conn = Faraday.get("https://dog.ceo/api/breeds/list/all")
    data = JSON.parse(conn.body, symbolize_names: true)
  end
end
