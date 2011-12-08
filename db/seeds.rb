# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

user_a = User.create({:name => "Christopher Oentojo", :age => 20, :email => "c.oentojo@gmail.com", :occupation => "Sales/Marketing", :state => "CA", :country => "USA", :gender => "male"})
user_b = User.create({:name => "Ben Sherman", :age => 25, :email => "c.oentojo+1@gmail.com", :occupation => "Sales/Marketing", :state => "CA", :country => "USA", :gender => "male"})
user_c = User.create({:name => "Fred Perry", :age => 53, :email => "c.oentojo+2@gmail.com", :occupation => "Architecture/Interior Design", :state => "CA", :country => "USA", :gender => "male"})
user_d = User.create({:name => "Gola", :age => 34, :email => "c.oentojo+3@gmail.com", :occupation => "Sales/Marketing", :state => "CA", :country => "USA", :gender => "female"})
user_e = User.create({:name => "Wallace", :age => 41, :email => "c.oentojo+4@gmail.com", :occupation => "Fashion/Model/Beauty", :state => "CA", :country => "USA", :gender => "female"})
user_f = User.create({:name => "Air Head", :age => 15, :email => "c.oentojo+5@gmail.com", :occupation => "Fashion/Model/Beauty", :state => "CA", :country => "USA", :gender => "male"})


number_1 = Number.create({:number => 10, :age => 1, :gender => "male", :temperment => "&#123;", :color => "#FF0000", :user_id => user_a.id})
number_2 = Number.create({:number => 10, :age => 4, :gender => "male", :temperment => "&#123;", :color => "#FF0000", :user_id => user_a.id})
number_3 = Number.create({:number => 10, :age => 8, :gender => "male", :temperment => "&#42;", :color => "#FF0000", :user_id => user_a.id})
number_4 = Number.create({:number => 10, :age => 22, :gender => "male", :temperment => "&#42;", :color => "#FFFF00", :user_id => user_a.id})
number_5 = Number.create({:number => 10, :age => 11, :gender => "female", :temperment => "&#42;", :color => "#FFFF00", :user_id => user_a.id})
number_6 = Number.create({:number => 10, :age => 41, :gender => "female", :temperment => "&#62;", :color => "#0000FF", :user_id => user_a.id})
number_7 = Number.create({:number => 10, :age => 72, :gender => "female", :temperment => "&#62;", :color => "#0000FF", :user_id => user_a.id})
number_8 = Number.create({:number => 10, :age => 15, :gender => "female", :temperment => "&#62;", :color => "#0000FF", :user_id => user_a.id})
number_9 = Number.create({:number => 10, :age => 34, :gender => "female", :temperment => "&#62;", :color => "#9900FF", :user_id => user_a.id})