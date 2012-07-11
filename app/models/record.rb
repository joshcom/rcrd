# app/models/record.rb
class Record < ActiveRecord::Base
  belongs_to :user
  has_many :cats
  accepts_nested_attributes_for :cats, :allow_destroy => true
  
  def self.home_page_records(current_user_id)
    Rails.cache.fetch("records_"+current_user_id.to_s) do
      records = self.find(:all, :conditions => ["user_id=? AND created_at > ?", current_user_id, 3.weeks.ago], :order => 'created_at DESC')
      return records.group_by { |r| r.created_at.beginning_of_day }
    end
  end
  
end