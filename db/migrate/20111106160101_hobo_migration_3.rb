class HoboMigration3 < ActiveRecord::Migration
  def self.up
    add_column :railroads, :user_id, :integer

    add_index :railroads, [:user_id]
  end

  def self.down
    remove_column :railroads, :user_id

    remove_index :railroads, :name => :index_railroads_on_user_id rescue ActiveRecord::StatementInvalid
  end
end
