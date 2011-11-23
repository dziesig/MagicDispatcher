class HoboMigration7 < ActiveRecord::Migration
  def self.up
    add_column :railroads, :eastbound_odd_numbers, :boolean, :default => false
    change_column :railroads, :north_south, :boolean, :default => false
    change_column :railroads, :west_south_on_right, :boolean, :default => false
  end

  def self.down
    remove_column :railroads, :eastbound_odd_numbers
    change_column :railroads, :north_south, :boolean
    change_column :railroads, :west_south_on_right, :boolean
  end
end
