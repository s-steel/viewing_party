class MovieData
  def initialize(data)
    data.each do |key, value|
      instance_variable_set("@#{key}", value)
      self.class.send(:attr_reader, key)
    end
  end

  def all_genres
    genres.map do |g|
      g[:name]
    end.join(', ')
  end
end
