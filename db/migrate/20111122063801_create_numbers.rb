class CreateNumbers < ActiveRecord::Migration
  def self.up
    create_table :numbers do |t|
      t.integer :age
      t.string :gender
      t.string :temperment
      t.string :occupation
      t.string :color
      t.integer :number
      t.references :user
    
      t.timestamps
    end
  end

  def self.down
    drop_table :numbers
  end
end
