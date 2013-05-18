class HomeController < ApplicationController
  def index 
    @num_days = 60  
    @cats = [
      {name: 'swim', color: 'blue', days: nil, header: 'swim practices'}, 
#      {name: 'meet', color: 'light-blue', days: nil, header: 'swim meets'}, 
      {name: 'run', color: 'blue', days: nil, header: 'runs'}, 
      {name: 'drink', color: 'red', days: nil, header: 'drinks'}] 
    @cats.each do |cat|
      puts cat[:name]
      cat[:days] = Record.get_cat_count_per_day(@num_days, cat[:name])
    end
  end

  def public 
  end

  def trends 
  end

  def input 
  end
end
