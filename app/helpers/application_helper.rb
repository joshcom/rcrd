module ApplicationHelper

  # Template macros
  # ===============

  def style_info(hue)
    "background-color: hsl(#{hue}, 80%, 60%);"
  end

  def no_mag(str)
    # TODO: this should un-pluralize as well
    str.gsub /^\s*\d+\s*/, ''
  end

end
