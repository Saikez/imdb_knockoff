require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')

def session
  last_request.env['rack.session']
end

describe "POST /session" do
  describe 'with valid credentials' do
    it 'creates a new session' do
      post '/session', { username: 'ben', password: 'p@55word' }

      assert session[:authenticated], 'Not authenticated'
    end

    it 'redirects to the movie action' do
      post '/session', { username: 'ben', password: 'p@55word' }

      assert last_response.redirect?, 'Didn\'t redirect!'
    end
  end

  describe 'with invalid credentials' do
    it 'redirects with a 403' do
      post '/session', { username: 'bad', password: 'bad' }

      assert_equal last_response.status, 403
    end
  end
end
