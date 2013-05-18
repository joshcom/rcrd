class HomeController < ApplicationController
  def index 
    @num_days = 60  
    @cats = [
      {name: 'swim', color: 'blue', days: nil}, 
      {name: 'meet', color: 'light-blue', days: nil}, 
      {name: 'run', color: 'blue', days: nil}, 
      {name: 'drink', color: 'red', days: nil}] 
    @cats.each do |cat|
      puts cat[:name]
      cat[:days] = Record.get_cat_count_per_day(@num_days, cat[:name])
    end
  end

  def dashboard
  end
end
