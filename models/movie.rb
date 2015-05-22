class Movie < ActiveRecord::Base
  validates :name, presence: true
  validates :rating, inclusion: { in: %w(1 2 3 4 5) }
end
