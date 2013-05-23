class HomeController < ApplicationController
  def index 
    @num_days = 60  
    @cats = [
      {name: 'swim', color: 'blue'}, 
      {name: 'meet', color: 'light-blue'}, 
      {name: 'run', color: 'green'}, 
      {name: 'drink', color: 'red'}] 
    @cats.each do |cat|
      puts cat[:name]
      cat[:days] = {}
      cat[:days] = Record.get_cat_count_per_day(@num_days, cat[:name])
    end
  end

  def public 
  end

  def trends 
    cats = ['swim', 'run', 'drink']
    @trends = [] 
    cats.each do |cat|
      trend = {} 
      trend[:name] = cat
      trend[:last_4_weeks] = Record.get_weekly_frequency_since(Date.today - 4.weeks, cat)
      trend[:last_8_weeks] = Record.get_weekly_frequency_since(Date.today - 8.weeks, cat)
      trend[:last_16_weeks] = Record.get_weekly_frequency_since(Date.today - 16.weeks, cat)
      @trends << trend
    end
  end
end
