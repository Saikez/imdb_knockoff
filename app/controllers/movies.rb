ImdbKnockoff::App.controllers :movies do
  before :new, :create do
    redirect url(:session, :new) unless session[:authenticated]
  end

  get :new do
    @movie = Movie.new

    render :new
  end

  post :create do
    movie = Movie.create!(params[:movie])

    redirect url(:movies, :show, id: movie.id)
  end

  get :show, map: 'movies/:id' do
    @movie = Movie.find(params[:id])

    render :show
  end

  get :index do
    @movies = Movie.all

    render :index
  end
end
