class AddElapsedSecondsToDpoints < ActiveRecord::Migration
  def change
    add_column :dpoints, :elapsed_seconds, :integer
  end
end
