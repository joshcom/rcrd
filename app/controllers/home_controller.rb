class HomeController < ApplicationController
  def index 
    @num_days = 60  
    query = "SELECT date_trunc('day', created_at) AS day, count(*) AS record_count FROM records WHERE created_at > now() - interval '#{@num_days} days' and user_id = 2 GROUP BY 1 ORDER BY 1"
    result = ActiveRecord::Base.connection.execute(query)

    @days = {} 

    (Date.today-@num_days...Date.today).each do |day|
      @days[day.strftime('%F')] = 0 
    end
    
    result.each do |res|
      date = Date.parse(res['day']).strftime('%F')
      @days[date] = res['record_count']
    end

    @days.keys.sort!
  end

  def dashboard
    puts 'hello'
  end
end
