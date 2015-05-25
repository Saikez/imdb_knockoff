ImdbKnockoff::App.controllers :movies do
  before :new, :create, :edit, :update, :delete do
    redirect url(:session, :new) unless session[:authenticated] || Padrino.env == :production
  end

  get :new do
    @movie = Movie.new

    render :new, locals: { path: url(:movies, :create), meth: :post }
  end

  post :create do
    @movie = Movie.create(params[:movie])

    if @movie.valid?
      redirect url(:movies, :show, id: @movie.id)
    else
      render :new, locals: { path: url(:movies, :create), meth: :post }
    end
  end

  delete :delete, map: '/movies/:id' do
    Movie.delete(params[:id])
    @movies = Movie.all

    redirect url(:movies, :index)
  end

  put :update, map: '/movies/:id' do
    @movie = Movie.find(params[:id])

    if @movie.update(params[:movie])
      redirect url(:movies, :show, id: @movie.id)
    else
      render :new, locals: { path: url(:movies, :update, id: @movie.id), meth: :put }
    end
  end

  get :edit, map: '/movies/:id/edit' do
    @movie = Movie.find(params[:id])

    render :new, locals: { path: url(:movies, :update, id: @movie.id), meth: :put }
  end

  get :show, map: '/movies/:id' do
    @movie = Movie.find(params[:id])

    render :show
  end

  get :index do
    @movies = Movie.all

    render :index
  end
end
