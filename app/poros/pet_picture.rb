class PetPicture
  attr_reader :picture

  def initialize(data)
    @picture = data[:message]
  end
end
