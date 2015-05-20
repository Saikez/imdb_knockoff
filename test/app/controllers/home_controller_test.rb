require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')

# describe "/home" do
#   before do
#     get "/home"
#   end

#   it "should return hello world text" do
#     assert_equal "Hello World", last_response.body
#   end
# end

describe '/' do
  before do
    get '/'
  end

  it 'responds OK' do
    assert last_response.ok?, "Wasn't OK!"
  end
end
