class HoboMigration10 < ActiveRecord::Migration
  def self.up
    create_table :track_connections do |t|
      t.string   :name
      t.datetime :created_at
      t.datetime :updated_at
    end
  end

  def self.down
    drop_table :track_connections
  end
end
