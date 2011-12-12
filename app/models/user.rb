class User < ActiveRecord::Base
  has_many :numbers
  
  def self.create_with_omniauth(auth) 
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
      user.email = auth["info"]["email"]
      user.gender = auth["info"]["gender"]
    end
  end
end
