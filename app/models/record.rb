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

  def self.get_trending_cats
    # Return an array of cats where frequency >= 3
    cat_freqs = self.get_list_of_cat_frequencies
    cat_freqs.sort_by {|k,v| v}
    return cat_freqs.keys[0..40]
  end

  def self.get_list_of_cat_frequencies
    # Go through all records
    cat_list = {}
    Record.all.each do |record|
      record.cats_from_raw.each do |cat|
        cat_list[cat] = 0  if !cat_list[cat]
        cat_list[cat] += 1
      end 
    end
    return cat_list
  end

  def cats_from_raw
    # Returns a records' cats derived from its raw text
    if self.raw
      raw_minus_mags = self.raw.tr('0-9', '').split /,/
      raw_minus_mags.map {|cat| cat.strip!}
      return raw_minus_mags
    else
      return [] 
    end
  end
end
