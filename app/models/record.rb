# app/models/record.rb
class Record < ActiveRecord::Base
  has_many :cats
end