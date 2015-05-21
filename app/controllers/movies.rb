ImdbKnockoff::App.controllers :movies do
  before :new, :create do
    redirect url(:session, :new) unless session[:authenticated]
  end

  get :new do
    render :new
  end

  post :create do
    movie = Movie.create!(name: params['name'], rating: params['rating'])

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
