class AddCountryStateToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :country, :string
    add_column :users, :state, :string
    remove_column :users, :location
  end

  def self.down
    add_column :users, :location, :string
    remove_column :users, :country
    remove_column :users, :state
  end
end
