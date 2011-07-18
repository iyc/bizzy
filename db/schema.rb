
# --------------------------------
class Schema
end

# --------------------------------
class XmlSchema < Schema
  # --------------------------------------------------------
  def initialize(schema_file)
    File.open(schema_file, "r") { |infile|
      while (line = infile.gets)
        case
        when "<Table " in 
        
      end
    }
  end
end

# --------------------------------
class Table
  attr_accessor :name, :columns
  def initialize(property_list)
    
  end
end

# --------------------------------
class Column
  attr_accessor :name, :type, :length
end

# --------------------------------
class Index
  attr_accessor :name, :columns
end

xmlSchema = XmlSchema.new('schema.xml')