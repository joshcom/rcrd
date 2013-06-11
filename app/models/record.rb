class Record < ActiveRecord::Base
  belongs_to :user
  attr_accessible :target, :raw, :user_id
  default_scope order 'target DESC'
  validates_presence_of :raw, :user_id #, :target

  # ✓ 2
  def time_zone_text
    if self.raw && self.raw.match("time zone")
      record = self
    else
      target = self.target || Time.now.utc
      record = Record.where("raw LIKE ? AND target < ?", '%time zone%', target).limit(1).first
    end
    if record
      cats = record.cats_from_raw
      cats.delete 'time zone' # not the most elegant thing in the world
      cats.first 
    else
      "Pacific Time (US & Canada)" 
    end
  end

  # ✗ 
  def time_zone
    ActiveSupport::TimeZone.new(self.time_zone_text)
  end

  # ✗ 
  def local_target
    self.target.in_time_zone(self.time_zone)
  end

  # ✗ 
  def local_target=(trg)
    # now not being used in records_controller
    puts "TESTING"
    puts trg
    self.target = trg # .in_time_zone(ActiveSupport::TimeZone.new("UTC")) # ALSO TESTING # - self.time_zone.utc_offset.seconds    
    
  end

  # ✗ 
  # Not sure if these may need to be deprecated
  def self.current_time_zone_text
    Record.limit(1).first.time_zone_text 
  end

  # ✗ 
  def self.current_time_zone
    ActiveSupport::TimeZone.new(self.current_time_zone_text)
  end

  # ✓
  def self.get_cats(name)
    self.where("raw LIKE ?", '%'+name+'%')
  end

  # ✗ 
  def self.get_cat_count_per_day(num_days, cat)

    num_days -= 1

    query = "SELECT date_trunc('day', (target at time zone 'PDT')) AS day, count(*) AS record_count FROM records WHERE target > ((now() - interval '#{num_days} days') at time zone 'PDT') AND user_id = 2 AND raw LIKE '%#{cat}%' GROUP BY 1 ORDER BY 1"
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

  # ✗ 
  def self.get_trending_cats
    cat_freqs = self.get_list_of_cat_frequencies
    cat_freqs.sort_by {|k,v| v}
    return cat_freqs.keys[0..40]
  end

  # ✗ 
  def self.get_list_of_cat_frequencies
    # Go through all records
    cat_list = {}
    Record.all.each do |record|
      record.cats_from_raw_without_mags.each do |cat|
        cat_list[cat] = 0 if !cat_list[cat]
        cat_list[cat] += 1
      end 
    end
    return cat_list
  end

  # ✓
  def cats_from_raw
    (self.raw || '').split(/,/).map {|cat| cat.strip}
  end

  # ✓
  def cats_from_raw_without_mags
   return cats_from_raw.map {|cat| cat.sub /^\s*\d+\.*\d*\s*/, '' }
  end

  # ✗ 
  def self.get_weekly_frequency_since(date, cat)
    records = Record.where("target > ? AND raw LIKE ?", date, '%'+cat+'%').count.to_f
    (records / ((Date.today - date).to_f / 7.0)).round(2)
  end

  # ✓
  def hue
   minutes = self.target.strftime('%k').to_f * 60.0
   minutes += self.target.strftime('%M').to_f
   ret =  (minutes / 1440.0)  * 360.0
   return ret
  end
end
