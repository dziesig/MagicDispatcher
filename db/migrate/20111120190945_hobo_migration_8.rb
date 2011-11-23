class HoboMigration8 < ActiveRecord::Migration
  def self.up
    add_column :tracks, :ul_id, :integer
    add_column :tracks, :cl_id, :integer
    add_column :tracks, :ll_id, :integer
    add_column :tracks, :ur_id, :integer
    add_column :tracks, :cr_id, :integer
    add_column :tracks, :lr_id, :integer

    add_index :tracks, [:ul_id]
    add_index :tracks, [:cl_id]
    add_index :tracks, [:ll_id]
    add_index :tracks, [:ur_id]
    add_index :tracks, [:cr_id]
    add_index :tracks, [:lr_id]
  end

  def self.down
    remove_column :tracks, :ul_id
    remove_column :tracks, :cl_id
    remove_column :tracks, :ll_id
    remove_column :tracks, :ur_id
    remove_column :tracks, :cr_id
    remove_column :tracks, :lr_id

    remove_index :tracks, :name => :index_tracks_on_ul_id rescue ActiveRecord::StatementInvalid
    remove_index :tracks, :name => :index_tracks_on_cl_id rescue ActiveRecord::StatementInvalid
    remove_index :tracks, :name => :index_tracks_on_ll_id rescue ActiveRecord::StatementInvalid
    remove_index :tracks, :name => :index_tracks_on_ur_id rescue ActiveRecord::StatementInvalid
    remove_index :tracks, :name => :index_tracks_on_cr_id rescue ActiveRecord::StatementInvalid
    remove_index :tracks, :name => :index_tracks_on_lr_id rescue ActiveRecord::StatementInvalid
  end
end
