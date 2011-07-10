class Sql
  attr_accessor :sql
  # -------------------------------------------------------
  def initialize()  ## .new, returns an instance
    @sql = ""
  end
  
  # -------------------------------------------------------
  def self.create(msg, &block)  ## returns sql, trashes the instance
    puts msg
    sql = Sql.new()
    sql.instance_eval(&block)
    return sql.sql  ## result set
  end
  
  # -------------------------------------------------------
  def from(table)
    @sql+=' from '+table
  end
  
  # -------------------------------------------------------
  def select(field)
    @sql+='select '+field
  end
    
end

sql = Sql.create 'creating', {
  select('a')
  from('table')
}

puts sql