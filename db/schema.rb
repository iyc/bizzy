
require File.dirname(__FILE__) + '/../rb/toolbox.rb'

# ------------------------------------------------------
class Schema
  attr_accessor :tables

  # ------------------------------------------------------
  def initiatlize()
    super
    @tables = []
  end
end

# ------------------------------------------------------
class XmlSchema < Schema
    
  # ------------------------------------------------------
  def initialize(schema_file)
    super() # if no ()'s it passes all params up
    @line_no = 1
    begin
      File.open(schema_file, "r") { |infile|
        while (line = infile.gets) 
          line.strip!
          case
            when line.start_with?("<Schema>")
            when line.start_with?("<Tables")
              @tables = []
            when line.start_with?("<Table ")
              table_props = line.sub("<Table ","").sub("/>","").sub(">","")
              @tables.push(Table.new(table_props))
            when line.start_with?("<Columns")
              @tables.last.columns = []
            when line.start_with?("<Column ")
              column_props = line.sub("<Column ","").sub("/>","").sub(">","")
              column = Column.new(column_props)
              @tables.last.columns.push(column)
            when line.start_with?("</Columns")
            when line.start_with?("<Indexes")
            when line.start_with?("</Tables")
            when line.start_with?("</Schema")
            else
          end#case
          @line_no = @line_no+1
        end#while
      }
    rescue 
      puts "Error found in xml at line "+@line_no.to_s
    end
    @tables.each { |table|
      puts ":"+table.name
      table.columns.each { |column|
        puts "  - " + column.name
      }
    }

    
  end#def
end

# ------------------------------------------------------
class Table
  include Toolbox
  attr_accessor :name, :columns

  # ------------------------------------------------------
  def initialize(prop_list)
    super()
    @name = ""
    @columns = []
    loadprops!(prop_list)
  end
end

# ------------------------------------------------------
class Column
  include Toolbox
  attr_accessor :name, :type, :length, :serial, :auto_increment, :sequence

  # ------------------------------------------------------
  def initialize(prop_list)
    super()
    @name = ""
    @type = ""
    @length = 0
    @serial = ""
    @auto_increment = ""
    @sequence = ""
    loadprops!(prop_list)
  end
end

# ------------------------------------------------------
class Index
  include Toolbox
  attr_accessor :name, :columns

  # ------------------------------------------------------
  def initialize(prop_list)
    super()
    @name = ""
    @columns = []
    loadprops!(prop_list)
  end
end

xmlSchema = XmlSchema.new('schema.xml')