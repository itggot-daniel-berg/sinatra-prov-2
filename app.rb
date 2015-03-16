class App < Sinatra::Base
  enable :sessions

  get '/' do
    @movies = Movie.all
    @cinemas = Cinema.all
    slim :index
  end

  get '/movie/:id' do |id|
    @movie = Movie.get(id)
    @cinemas = @movie.cinemas
    slim :movie
  end

  get '/cinema/:id' do |id|
    @cinema = Cinema.get(id)
    @movies = @cinema.movies
    slim :cinema
  end

  get '/cinema/:id/movie/:id' do |cinema_id, movie_id|
    @cinema = Cinema.get(cinema_id)
    @movie = Movie.get(movie_id)
    @showings = @movie.showings(cinema: @cinema)
    slim :showings
  end

  post '/book/showing/:id' do |id|
    showing = Showing.get(id)

    Booking.create(showing: showing)
    redirect back
  end

end