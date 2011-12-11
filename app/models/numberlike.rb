class Numberlike < ActiveRecord::Base
  validates :user_id, :presence => true, :uniqueness => {:scope => :num1}
end
