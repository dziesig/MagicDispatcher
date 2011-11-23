class HoboMigration6 < ActiveRecord::Migration
  def self.up
    add_column :railroads, :north_south, :boolean
    add_column :railroads, :west_south_on_right, :boolean
  end

  def self.down
    remove_column :railroads, :north_south
    remove_column :railroads, :west_south_on_right
  end
end
