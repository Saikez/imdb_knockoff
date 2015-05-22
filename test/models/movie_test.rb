require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

describe Movie do
  it 'can construct a new instance' do
    movie = Movie.new
    refute_nil movie
  end
end

describe 'validation' do
  it 'is valid with valid attribute' do
    assert Movie.new(name: 'Jaws', rating: 5).valid?
  end

  it 'requires a name' do
    assert Movie.new(rating: 5).invalid?
  end

  it 'requires a rating between 1 and 5' do
    assert Movie.new(name: 'Jaws', rating: 42).invalid?
    assert Movie.new(name: 'Jaws', rating: -1).invalid?
    assert Movie.new(name: 'Jaws', rating: 0).invalid?
  end
end
