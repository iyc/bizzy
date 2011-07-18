
module Kernel
  # -----------------------------------------------------
  def Boolean(string)
    return true if string == true || string =~ /^true$/i
    return false if string == false || string.nil? || string =~ /^false$/i
    raise ArgumentError.new("invalid value for Boolean: \"#{string}\"")
  end

end

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
def loadprops(prop_list, obj=self)
  prop_arr = prop_list.split(" ")
  prop_arr.each { |prop_assignment|
    prop_name = prop_assignment.split("=").first
    prop_value = prop_assignment.split("=").last
    class_type = eval("obj.#{prop_name}.class")
    eval("obj.#{prop_assignment}")
    converted_value = string_to_type(eval("obj.#{prop_name}"), class_type)
    puts converted_value
    eval("obj.#{prop_name} = #{converted_value}")
  }
end


class Test
  attr_accessor :string, :number, :date, :datetime, :boolean
  def initialize()
    @string = ""
    @number = 0
    @boolean = false
    @extra = "cats"
  end
  
  def to_s    
    string = "string=#{@string}; number=#{@number}; boolean=#{@boolean}; extra=#{@extra}"
    return string
  end
end

t = Test.new
#props = 'number="10" boolean="true" string="dogs"'
props = "number='10' boolean='true' string='dogs'"
loadprops(props, t)
puts t.to_s
puts t.string + " - testing"
puts t.number + 10