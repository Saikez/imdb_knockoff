require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')

describe 'GET /movies' do
  before do
    @movie = Movie.create!(name: 'Jaws', rating: 5)
    @movie2 = Movie.create!(name: 'Jaws 2', rating: 3)
    get "/movies/#{@movie.id}"
  end

  it 'responds OK' do
    get '/movies'

    assert last_response.ok?
  end

  it 'lists the saved movies' do
    get '/movies'

    assert_includes last_response.body, @movie.name
    assert_includes last_response.body, @movie2.name
  end

  it 'has a `new movie` link' do
    get '/movies'

    assert_includes last_response.body, 'New Movie'
  end
end

describe 'GET /movies/new' do
  describe 'when unauthenticated' do
    it 'redirects to the login page' do
      get '/movies/new'

      assert last_response.redirect?, 'Didn\'t redirect'
    end
  end

  describe 'when authenticated' do
    it 'responds OK' do
      get '/movies/new',
        {},
        { 'rack.session' => { authenticated: true } }

      assert last_response.ok?
    end
  end
end

describe 'GET /movies/:id' do
  before do
    @movie = Movie.create!(name: 'Jaws', rating: 5)
    get "/movies/#{@movie.id}"
  end

  it 'displays the name' do
    assert_includes last_response.body, @movie.name
  end

  it 'displays the rating' do
    assert_includes last_response.body, ('★' * @movie.rating.to_i)
  end
end

describe 'POST /movies' do
  describe 'when unauthenticated' do
    it 'redirects to the login page' do
      post '/movies/create', { name: 'Jaws', rating: 5 }

      assert last_response.redirect?, 'Not redirecting'
      assert_includes last_response.location, '/session/new'
    end
  end

  describe 'when authenticated' do
    before do
      post '/movies/create',
        { name: 'Jaws', rating: 5 },
        { 'rack.session' => { authenticated: true } }
    end

    it 'creates a movie' do
      jaws = Movie.first

      assert_equal jaws.name, 'Jaws'
      assert_equal jaws.rating, '5'
    end

    it 'redirects to our new movie' do
      assert last_response.redirect?
    end
  end
end
