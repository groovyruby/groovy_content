class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name
  
  def to_liquid
    {'email'=>self.email, 'id'=>self.id, 'first_name'=>self.first_name, 'last_name'=>self.last_name}
  end
end
