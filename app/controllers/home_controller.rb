class HomeController < ApplicationController

  def index 
    @num_days = 60  
    @cats = [
      {name: 'workout', color: '96b4fd'}, 
      {name: 'swim', color: '032780'}, 
      {name: 'meet', color: '032780'}, 
      {name: 'run', color: '009942'}, 
      {name: 'drink', color: 'D42627'}, 
      {name: 'movie', color: 'F1681E'}] 
    @cats.each do |cat|
      puts cat[:name]
      cat[:days] = {}
      cat[:days] = Record.get_cat_count_per_day(@num_days, cat[:name])
    end

    trend_cats = ['workout', 'swim', 'run', 'drink']
    @trends = [] 
    trend_cats.each do |cat|
      trend = {} 
      trend[:name] = cat
      trend[:last_4_weeks] = Record.get_weekly_frequency_since(Date.today - 4.weeks, cat)
      trend[:last_8_weeks] = Record.get_weekly_frequency_since(Date.today - 8.weeks, cat)
      trend[:last_16_weeks] = Record.get_weekly_frequency_since(Date.today - 16.weeks, cat)
      @trends << trend
    end
  end

end
