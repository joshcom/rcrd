class HomeController < ApplicationController

#  def index
    # aggregate of everyone's cats
    # log in

#  end

  def index 
    @num_days = 60  
    @cats = [
      {name: 'workout', color: '96b4fd', avgs: true}, 
      {name: 'swim', color: '032780', avgs: true}, 
      {name: 'run', color: '009942', avgs: true, day_avgs: true}, 
      {name: 'drink', color: 'D42627', avgs: true, mag_avgs: true},
      {name: 'walk', color: 'cf0b7b'}] 
    @cats.each do |cat|
      cat[:days] = {}
      cat[:days] = Record.get_cat_count_per_day(@num_days, cat[:name])

      if cat.has_key?(:avgs) && cat[:avgs]
        cat[:last_4_weeks] = Record.get_weekly_frequency_since(Date.today - 4.weeks, cat[:name])
        cat[:last_8_weeks] = Record.get_weekly_frequency_since(Date.today - 8.weeks, cat[:name])
        cat[:last_16_weeks] = Record.get_weekly_frequency_since(Date.today - 16.weeks, cat[:name])
      end
    end
  end

end
