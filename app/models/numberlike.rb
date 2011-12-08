class Numberlike < ActiveRecord::Base
  validates :user_id, :uniqueness => {:scope => :num1}
end
