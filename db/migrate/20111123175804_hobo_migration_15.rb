class HoboMigration15 < ActiveRecord::Migration
  def self.up
    add_column :tracks, :track_class, :string
    add_column :tracks, :length, :integer
  end

  def self.down
    remove_column :tracks, :track_class
    remove_column :tracks, :length
  end
end
