class Favorite
  attr_reader :content

  def initialize(initial_contents)
    @content = initial_contents || Hash.new(0)
  end

  def count_of(id)
    @content[id].to_i
  end

  def add_favorite(id) #setting the key to the pet_id and the value to 1
    @content[id] = count_of(id) + 1
  end

  def favorite_count
    @content.values.sum
  end

end
