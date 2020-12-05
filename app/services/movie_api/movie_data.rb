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

  def format_run_time
    total_minutes = runtime
    hours = total_minutes / 60
    mins = total_minutes % 60
    "#{hours} hr #{mins} min"
  end
end
