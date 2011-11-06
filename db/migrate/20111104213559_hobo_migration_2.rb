class HoboMigration2 < ActiveRecord::Migration
  def self.up
    create_table :railroads do |t|
      t.string   :name
      t.datetime :created_at
      t.datetime :updated_at
    end
  end

  def self.down
    drop_table :railroads
  end
end
