class CatPicture
  attr_reader :picture, :width, :height, :name

  def initialize(data)
    @picture = data[:url]
    @width = data[:width]
    @height = data[:height]
    @name = data[:name]
  end
end
