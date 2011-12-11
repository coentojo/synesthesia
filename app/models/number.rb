class Number < ActiveRecord::Base
  belongs_to :user
  validates :user_id, :uniqueness => {:scope => :number}
  # validates :age, :presence => true
  # validates :gender, :presence => true
  # validates :temperment, :presence => true
  # validates :color, :presence => true
end
