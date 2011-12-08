class CreateNumberlikes < ActiveRecord::Migration
  def self.up
    create_table :numberlikes do |t|
      t.integer :num1
      t.string :verb
      t.integer :num2

      t.timestamps
    end
  end

  def self.down
    drop_table :numberlikes
  end
end
