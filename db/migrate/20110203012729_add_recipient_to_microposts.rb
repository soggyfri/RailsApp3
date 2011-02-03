class AddRecipientToMicroposts < ActiveRecord::Migration
  def self.up
    add_column :microposts, :recipient, :integer
  end

  def self.down
    remove_column :microposts, :recipient
  end
end
