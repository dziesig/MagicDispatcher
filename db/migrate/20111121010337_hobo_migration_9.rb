class HoboMigration9 < ActiveRecord::Migration
  def self.up
    create_table :track_types do |t|
      t.string   :name
      t.integer  :index
      t.datetime :created_at
      t.datetime :updated_at
    end

    add_column :tracks, :track_type_id, :integer

    add_index :tracks, [:track_type_id]
  end

  def self.down
    remove_column :tracks, :track_type_id

    drop_table :track_types

    remove_index :tracks, :name => :index_tracks_on_track_type_id rescue ActiveRecord::StatementInvalid
  end
end
