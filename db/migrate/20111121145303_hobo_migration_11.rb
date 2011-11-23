class HoboMigration11 < ActiveRecord::Migration
  def self.up
    drop_table :track_connections
  end

  def self.down
    create_table "track_connections", :force => true do |t|
      t.string   "name"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
end
