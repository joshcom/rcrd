# app/models/cat.rb
class Cat < ActiveRecord::Base
  belongs_to :records
end
