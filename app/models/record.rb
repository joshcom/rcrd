# app/models/record.rb
class Record < ActiveRecord::Base
  has_many :cats
  accepts_nested_attributes_for :cats, :allow_destroy => true
end