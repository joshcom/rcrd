class User < ActiveRecord::Base
  authenticates_with_sorcery!
  
  has_many :records
  has_many :karmas
  
  attr_accessible :username, :email, :password, :password_confirmation, :time_zone

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email
end
