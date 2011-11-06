class HoboMigration1 < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.string   :name
      t.string   :description
      t.datetime :created_at
      t.datetime :updated_at
    end

    create_table :permissions do |t|
      t.string   :name
      t.string   :description
      t.datetime :created_at
      t.datetime :updated_at
    end

    create_table :permission_roles do |t|
      t.integer :role_id
      t.integer :permission_id
    end
    add_index :permission_roles, [:role_id]
    add_index :permission_roles, [:permission_id]

    add_column :users, :use_secondary_role, :boolean, :default => false
    add_column :users, :primary_role_id, :integer
    add_column :users, :secondary_role_id, :integer

    add_index :users, [:primary_role_id]
    add_index :users, [:secondary_role_id]
  end

  def self.down
    remove_column :users, :use_secondary_role
    remove_column :users, :primary_role_id
    remove_column :users, :secondary_role_id

    drop_table :roles
    drop_table :permissions
    drop_table :permission_roles

    remove_index :users, :name => :index_users_on_primary_role_id rescue ActiveRecord::StatementInvalid
    remove_index :users, :name => :index_users_on_secondary_role_id rescue ActiveRecord::StatementInvalid
  end
end
