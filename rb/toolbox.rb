
# -----------------------------------------------------
module Kernel
  # -----------------------------------------------------
  def Boolean(string)
    return true if string == true || string =~ /^true$/i
    return false if string == false || string.nil? || string =~ /^false$/i
    raise ArgumentError.new("invalid value for Boolean: \"#{string}\"")
  end

end

# -----------------------------------------------------
module Toolbox
  
  # -----------------------------------------------------
  def string_to_type(string, class_type)
    case 
    when class_type == Fixnum || class_type == Integer
      return Integer(string)
    when class_type == Float
      return Float(string)
    when class_type == String
      return String(string)
    when class_type == TrueClass || class_type == FalseClass
      return Boolean(string)
    when class_type == NilClass
      return nil
    end
  end

  # -----------------------------------------------------
  def loadprops!(prop_list, obj=self)

    prop_list.split(" ").each { |prop_assignment|

      prop_name = prop_assignment.split("=").first
      prop_value = prop_assignment.split("=").last
      class_type = eval("obj.#{prop_name}.class")

      eval("obj.#{prop_assignment}")  # run the assignment

      if class_type!=String
        # breaks with strings
        converted_value = string_to_type(eval("obj.#{prop_name}"), class_type)
        eval("obj.#{prop_name} = #{converted_value}")
      end#if

    }

  end#def
end#module