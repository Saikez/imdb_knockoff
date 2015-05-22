ImdbKnockoff::App.controllers :movies do
  before :new, :create, :edit do
    redirect url(:session, :new) unless session[:authenticated]
  end

  get :new do
    @movie = Movie.new

    render :new
  end

  post :create do
    @movie = Movie.create(params[:movie])

    if @movie.valid?
      redirect url(:movies, :show, id: @movie.id)
    else
      render :new
    end
  end

  put :update, map: '/movies/:id/update' do
    @movie = Movie.find(params[:id])

    @movie.update_attributes(params[:movie])
  end

  get :edit, map: 'movies/:id/edit' do
    @movie = Movie.find(params[:id])

    if @movie.valid?
      Movie.update(@movie.id, params[:movie])
      redirect url(:movies, :show, id: @movie.id)
    else
      render :edit
    end
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
