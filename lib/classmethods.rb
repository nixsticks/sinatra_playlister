module ClassMethods
  def all
    instance_variables.each {|var| return return_value(var) if return_value(var).is_a?(Array)}
  end

  def count
    instance_variables.each {|var| return return_value(var).size if return_value(var).is_a?(Array)} 
  end

  def reset
    instance_variables.each {|var| return_value(var).clear if return_value(var).is_a?(Array)}
  end

  def return_value(variable)
    self.instance_variable_get(variable)
  end
end
