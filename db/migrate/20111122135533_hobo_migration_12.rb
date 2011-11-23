class HoboMigration12 < ActiveRecord::Migration
  def self.up
    add_column :tracks, :ul_ext, :integer
    add_column :tracks, :cl_ext, :integer
    add_column :tracks, :ll_ext, :integer
    add_column :tracks, :ur_ext, :integer
    add_column :tracks, :cr_ext, :integer
    add_column :tracks, :lr_ext, :integer
  end

  def self.down
    remove_column :tracks, :ul_ext
    remove_column :tracks, :cl_ext
    remove_column :tracks, :ll_ext
    remove_column :tracks, :ur_ext
    remove_column :tracks, :cr_ext
    remove_column :tracks, :lr_ext
  end
end
