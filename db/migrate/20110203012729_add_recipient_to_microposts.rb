class AddRecipientToMicroposts < ActiveRecord::Migration
  def self.up
    add_column :microposts, :recipient, :integer
    add_index  :microposts, :recipient
  end

  def self.down
    remove_column :microposts, :recipient
  end
end
