class Record < ActiveRecord::Base
  belongs_to :user
  attr_accessible :target, :raw, :user_id
  default_scope order 'target DESC'
  validates_presence_of :raw, :user_id #, :target

  def time_zone
    if self.raw && self.raw.match("time zone")
      record = self
    else
      target = self.target || Time.now.utc
      record = record.user.records.where("raw LIKE ? AND target < ?", '%time zone%', target).limit(1).first
    end
    if record
      cats = record.cats_from_raw
      cats.delete 'time zone' # not the most elegant thing in the world
      zone_text = cats.first 
    else
      zone_text = "Pacific Time (US & Canada)" 
    end
    ActiveSupport::TimeZone.new(zone_text)
  end

  def local_target
    self.target.in_time_zone(self.time_zone)
  end

  def self.get_cats(name)
    self.where("raw LIKE ?", '%'+name+'%')
  end

  def self.get_cat_count_per_day(num_days, cat)

    num_days -= 1
    # note: this encompasses all users...
    query = "SELECT date_trunc('day', (target at time zone 'PDT')) AS day, count(*) AS record_count FROM records WHERE target > ((now() - interval '#{num_days} days') at time zone 'PDT') AND raw LIKE '%#{cat}%' GROUP BY 1 ORDER BY 1"
    result = ActiveRecord::Base.connection.execute(query)
#
    days = {} 

    (Date.today-num_days..Date.today).each do |day|
      days[day.strftime('%F')] = 0 
    end

    result.each do |res|
      date = Date.parse(res['day']).strftime('%F')
      days[date] = res['record_count']
    end

    days.keys.sort!
    return days
  end

  def self.get_trending_cats(user)
    cat_freqs = self.get_list_of_cat_frequencies(user)
    cat_freqs.sort_by {|k,v| v}
    return cat_freqs.keys[0..40]
  end

  def self.get_list_of_cat_frequencies(user)
    # Go through all records
    cat_list = {}
    user.records.each do |record|
      record.cats_from_raw_without_mags.each do |cat|
        cat_list[cat] = 0 if !cat_list[cat]
        cat_list[cat] += 1
      end 
    end
    return cat_list
  end

  def cats_from_raw
    (self.raw || '').split(/,/).map {|cat| cat.strip}
  end

  def cats_from_raw_without_mags
   return cats_from_raw.map {|cat| cat.sub /^\s*\d+\.*\d*\s*/, '' }
  end

  def self.get_weekly_frequency_since(date, cat)
    records = Record.where("target > ? AND raw LIKE ?", date, '%'+cat+'%').count.to_f
    (records / ((Date.today - date).to_f / 7.0)).round(2)
  end

  def hue
   minutes = self.target.strftime('%k').to_f * 60.0
   minutes += self.target.strftime('%M').to_f
   ret =  (minutes / 1440.0)  * 360.0
   return ret
  end
end
