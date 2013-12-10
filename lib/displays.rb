module Introspectable
  def get_instance_variables
    instance_variables.each {|variable| return_value(variable)}
  end

  def return_value(variable)
    instance_variable_get(variable)
  end
end


class Display
  def initialize(object)
    object.instance_variables.each {|variable| instance_variable_set("@#{variable}", instance_variable_get(variable))}
  end

  def summary
    
  end

  def page
  end
end

class CompositeDisplay
  attr_accessor :subdisplays

  def initialize
    super
    @subdisplays = []
  end

  def <<(display)
    subdisplays << display
  end

  def remove_display(display)
    subdisplays.delete(display)
  end

  def index
  end
end

class ArtistDisplay < CompositeDisplay
  # add all artist displays?
  def initialize(array)
    super
    array.each {|object| self << object}
  end

  def page

  end
end