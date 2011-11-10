class HoboMigration5 < ActiveRecord::Migration
  def self.up
    add_column :sections, :branch_id, :integer

    add_column :branches, :railroad_id, :integer

    add_column :tracks, :section_id, :integer

    add_index :sections, [:branch_id]

    add_index :branches, [:railroad_id]

    add_index :tracks, [:section_id]
  end

  def self.down
    remove_column :sections, :branch_id

    remove_column :branches, :railroad_id

    remove_column :tracks, :section_id

    remove_index :sections, :name => :index_sections_on_branch_id rescue ActiveRecord::StatementInvalid

    remove_index :branches, :name => :index_branches_on_railroad_id rescue ActiveRecord::StatementInvalid

    remove_index :tracks, :name => :index_tracks_on_section_id rescue ActiveRecord::StatementInvalid
  end
end
