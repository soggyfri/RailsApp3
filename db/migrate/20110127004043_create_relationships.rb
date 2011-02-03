class CreateRelationships < ActiveRecord::Migration
  def self.up
    create_table :relationships do |t|
      t.integer :user_id
      t.integer :friend_id
      t.boolean :approved
      t.timestamps
    end

		add_index :relationships, :user_id
		add_index :relationships, :friend_id
		add_index :relationships, [:user_id, :friend_id], :unique => true
    change_column_default(:relationships, :approved, false)
  end

  def self.down
    drop_table :relationships
  end
end
