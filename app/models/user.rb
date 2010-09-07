class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  validate :first_name, :required=>true
  validate :last_name, :required=>true

  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name
end
