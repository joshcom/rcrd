# app/models/record.rb
class Record < ActiveRecord::Base
  belongs_to :user
  has_many :cats
  accepts_nested_attributes_for :cats, :allow_destroy => true
end