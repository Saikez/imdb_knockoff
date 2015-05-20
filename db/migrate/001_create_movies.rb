class CreateMovies < ActiveRecord::Migration
  def self.up
    create_table :movies do |t|
      t.string :name
      t.string :rating
      t.timestamps null: false
    end
  end
end
