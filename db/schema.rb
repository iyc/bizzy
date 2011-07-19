
require require File.dirname(__FILE__) + '/../rb/toolbox.rb'

# --------------------------------
class Schema
  attr_accessor :tables
  def initiatlize()
    super
    @tables = {}  
end

# --------------------------------
class XmlSchema < Schema
  # --------------------------------------------------------
  def initialize(schema_file)
    super
    File.open(schema_file, "r") { |infile|
      while (line = infile.gets) 
        case
          when line.start_with?("<Schema>")
          when line.start_with?("<Tables")
            @tables = {}
          when line.start_with?("<Table ")
            table_props = line.sub("<Table ","").sub("/>","")
            table = Table.new(table_props)
            @tables[table.name] = table
          when line.start_with?("<Columns")
          when line.start_with?("<Column ")
            column_props = line.sub("<Column ","").sub("/>","")
            column = Column.new(column_props)
            @tables.last.columns[column.name] = column
          when line.start_with?("</Columns")
          when line.start_with?("<Indexes")
          when line.start_with?("</Tables")
          when line.start_with?("</Schema")
        end#case
      end#while
    }
  end#def
end

# --------------------------------
class Table
  include Toolbox
  attr_accessor :name, :columns
  def initialize(prop_list)
    loadprops!(prop_list)
    @columns = {}
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