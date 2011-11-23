class HoboMigration16 < ActiveRecord::Migration
  def self.up
    add_column :sections, :arrival_instructions, :text
  end

  def self.down
    remove_column :sections, :arrival_instructions
  end
end
