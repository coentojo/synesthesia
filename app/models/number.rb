class Number < ActiveRecord::Base
  belongs_to :user
  validates :user_id, :uniqueness => {:scope => :number}
end
