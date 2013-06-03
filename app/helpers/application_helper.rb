module ApplicationHelper

  # Template macros
  # ===============

  def style_info(hue)
    str = "background-color: hsl(#{hue}, 65%, 48%);"
    str += "border-bottom: solid 2px hsl(#{hue}, 80%, 20%);"
    str += "text-shadow: 0 -1px 1px hsl(#{hue}, 30%, 0%);"
  end

  def no_mag(str) # Possibly rename to 'tokenize'
    str.gsub! /^\s*\d+\.*\d*\s*/, ''
    str.singularize
  end

end
