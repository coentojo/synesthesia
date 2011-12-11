class AddUserIdToNumberlike < ActiveRecord::Migration
  def self.up
    add_column :numberlikes, :user_id, :integer
  end

  def self.down
    remove_column :numberlikes, :user_id, :integer
  end
end