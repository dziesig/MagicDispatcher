class HoboMigration13 < ActiveRecord::Migration
  def self.up
    create_table :track_connections do |t|
      t.string   :name
      t.integer  :index
      t.boolean  :left
      t.boolean  :top
      t.boolean  :center
      t.boolean  :bottom
      t.datetime :created_at
      t.datetime :updated_at
    end
  end

  def self.down
    drop_table :track_connections
  end
end
