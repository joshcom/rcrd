module ApplicationHelper

  def add_plus(string)
    string = string.to_s
    if string.match(/^\d{1}/) 
      # return raw '<span class="positive">+'+string+'</span>'
      return '+'+string
    else
      # return raw '<span class="negative">'+string+'</span>'
      return string
    end
  end
  
  def calculate_movement(records) 
    movement = 0
    records.each do |r|
      r.cats.each do |c|
          movement += c.karma unless !c.karma
      end
    end
    return movement
  end
  
  def calculate_absolute(records)
    movement = 0
    records.each do |r|
      r.cats.each do |c|
          movement += c.karma.abs unless !c.karma
      end
    end
    return movement
  end
  
  def csv_export_helper
    CSV.generate do |csv| 
      @records.each do |r|
        r.cats.each do |c|
          if @cat_name == c.name
            csv << [c.name, r.created_at.strftime("%d/%m/%Y"), c.magnitude]
          end
        end
      end
    end
  end
  
end
