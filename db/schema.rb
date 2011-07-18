
# --------------------------------
class Schema
end

# --------------------------------
class XmlSchema < Schema
  # --------------------------------------------------------
  def initialize(schema_file)
    
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