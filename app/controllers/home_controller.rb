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
    @trends = Record.get_trending_cats
  end

  def input 
    @trending = Record.get_trending_cats
  end
end
