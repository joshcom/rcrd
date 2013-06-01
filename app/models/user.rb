class User < ActiveRecord::Base
  has_many :records
  attr_accessible :email, :time_zone
  validates_presence_of :email
  validates_uniqueness_of :email
end
