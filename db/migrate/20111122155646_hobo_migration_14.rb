class HoboMigration14 < ActiveRecord::Migration
  def self.up
    rename_column :tracks, :ul_ext, :ul_ext_id
    rename_column :tracks, :cl_ext, :cl_ext_id
    rename_column :tracks, :ll_ext, :ll_ext_id
    rename_column :tracks, :ur_ext, :ur_ext_id
    rename_column :tracks, :cr_ext, :cr_ext_id
    rename_column :tracks, :lr_ext, :lr_ext_id

    add_index :tracks, [:ul_ext_id]
    add_index :tracks, [:cl_ext_id]
    add_index :tracks, [:ll_ext_id]
    add_index :tracks, [:ur_ext_id]
    add_index :tracks, [:cr_ext_id]
    add_index :tracks, [:lr_ext_id]
  end

  def self.down
    rename_column :tracks, :ul_ext_id, :ul_ext
    rename_column :tracks, :cl_ext_id, :cl_ext
    rename_column :tracks, :ll_ext_id, :ll_ext
    rename_column :tracks, :ur_ext_id, :ur_ext
    rename_column :tracks, :cr_ext_id, :cr_ext
    rename_column :tracks, :lr_ext_id, :lr_ext

    remove_index :tracks, :name => :index_tracks_on_ul_ext_id rescue ActiveRecord::StatementInvalid
    remove_index :tracks, :name => :index_tracks_on_cl_ext_id rescue ActiveRecord::StatementInvalid
    remove_index :tracks, :name => :index_tracks_on_ll_ext_id rescue ActiveRecord::StatementInvalid
    remove_index :tracks, :name => :index_tracks_on_ur_ext_id rescue ActiveRecord::StatementInvalid
    remove_index :tracks, :name => :index_tracks_on_cr_ext_id rescue ActiveRecord::StatementInvalid
    remove_index :tracks, :name => :index_tracks_on_lr_ext_id rescue ActiveRecord::StatementInvalid
  end
end
