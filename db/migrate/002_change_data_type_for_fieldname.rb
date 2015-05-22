class ChangeDataTypeForFieldname < ActiveRecord::Migration
  def change
    change_table :movies do |t|
      t.change :rating, :integer
    end
  end
end
