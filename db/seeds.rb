# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

user_a = User.create({:name => "Christopher Oentojo", :age => 20, :email => "c.oentojo@gmail.com", :occupation => "Sales/Marketing", :location => "Mountian View, CA", :gender => "male"})
user_b = User.create({:name => "Ben Sherman", :age => 25, :email => "c.oentojo+1@gmail.com", :occupation => "Sales/Marketing", :location => "Palo Alto, CA", :gender => "male"})
user_c = User.create({:name => "Fred Perry", :age => 53, :email => "c.oentojo+2@gmail.com", :occupation => "Architecture/Interior Design", :location => "Redwood City, CA", :gender => "male"})
user_d = User.create({:name => "Gola", :age => 34, :email => "c.oentojo+3@gmail.com", :occupation => "Sales/Marketing", :location => "Santa Clara, CA", :gender => "female"})
user_e = User.create({:name => "Wallace", :age => 41, :email => "c.oentojo+4@gmail.com", :occupation => "Fashion/Model/Beauty", :location => "San Jose, CA", :gender => "female"})
user_f = User.create({:name => "Air Head", :age => 15, :email => "c.oentojo+5@gmail.com", :occupation => "Fashion/Model/Beauty", :location => "Mountian View, CA", :gender => "male"})


number_1 = Number.create({:number => 10, :age => 1, :gender => "male", :temperment => "happy", :occupation => "Sales/Marketing", :color => "red", :user_id => user_a.id})
number_2 = Number.create({:number => 10, :age => 10, :gender => "male", :temperment => "happy", :occupation => "Fashion/Model/Beauty", :color => "yellow", :user_id => user_b.id})
number_3 = Number.create({:number => 10, :age => 31, :gender => "male", :temperment => "mad", :occupation => "Fashion/Model/Beauty", :color => "red", :user_id => user_c.id})
number_4 = Number.create({:number => 10, :age => 42, :gender => "female", :temperment => "mad", :occupation => "Sales/Marketing", :color => "yellow", :user_id => user_d.id})
number_5 = Number.create({:number => 10, :age => 23, :gender => "female", :temperment => "happy", :occupation => "Architecture/Interior Design", :color => "yellow", :user_id => user_e.id})
number_6 = Number.create({:number => 10, :age => 51, :gender => "female", :temperment => "happy", :occupation => "Architecture/Interior Design", :color => "red", :user_id => user_f.id})