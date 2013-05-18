class Record < ActiveRecord::Base
  belongs_to :user
  has_many :cats
  accepts_nested_attributes_for :cats, :allow_destroy => true

  def self.get_cat_count_per_day(num_days, cat)
    query = "SELECT date_trunc('day', created_at) AS day, count(*) AS record_count FROM records WHERE created_at > now() - interval '#{num_days} days' AND user_id = 2 AND raw LIKE '%#{cat}%' GROUP BY 1 ORDER BY 1"
    result = ActiveRecord::Base.connection.execute(query)
#
    days = {} 

    (Date.today-num_days...Date.today).each do |day|
      days[day.strftime('%F')] = 0 
    end
    
    result.each do |res|
      date = Date.parse(res['day']).strftime('%F')
      days[date] = res['record_count']
    end

    days.keys.sort!
    return days
  end

end
