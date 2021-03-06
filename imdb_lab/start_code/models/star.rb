require_relative('../db/sql_runner')

class Star

  attr_accessor :id

  def initialize(options)
    @id = options['id'].to_i if options['id'] != nil
    @first_name = options['first_name']
    @last_name = options['last_name']
  end

  # Create

  def save()
    sql = "INSERT INTO stars (first_name, last_name) VALUES ($1, $2) RETURNING id"
    values = [@first_name, @last_name]
    result = SqlRunner.run(sql, values)
    @id = result.first['id'].to_i
  end




  # Read
  def movies()
    sql = "SELECT movies.* FROM movies INNER JOIN castings ON castings.movie_id = movies.id WHERE castings.star_id = $1;"
    values = [@id]
    result = SqlRunner.run(sql, values)
    movies = result.map {|movie| Movie.new(movie)}
    return movies
  end

  # Update


  # Delete


end
