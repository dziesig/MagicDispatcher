class HoboMigration4 < ActiveRecord::Migration
  def self.up
    create_table :sections do |t|
      t.string   :name
      t.datetime :created_at
      t.datetime :updated_at
    end

    create_table :branches do |t|
      t.string   :name
      t.datetime :created_at
      t.datetime :updated_at
    end

    create_table :tracks do |t|
      t.string   :name
      t.datetime :created_at
      t.datetime :updated_at
    end
  end

  def self.down
    drop_table :sections
    drop_table :branches
    drop_table :tracks
  end
end
