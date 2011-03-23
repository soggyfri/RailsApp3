class CreateUserImages < ActiveRecord::Migration
  def self.up
    create_table :user_images do |t|
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :user_images
  end
end
