
# -----------------------------------------------------------
def sql(&new_sql_block)
  Sql.new(&new_sql_block)
end

# -----------------------
class Sql < Object
  
  attr_accessor :joins

  # -----------------------------------------------------------
  def initialize(&sql_block)
    super
    
    @basetable = ""
    @fields, @joins, @wheres, @havings, @orders = [], [], [], [], []
    @joins =  {} # named hash of SqlTables, by table alias
    @wheres.push(SqlWhere.new(self))
  
    if block_given?
      self.instance_eval(&sql_block)
    end
  end

  # -----------------------------------------------------------
  def select(field_expression, field_alias=field_expression)
    return @fields.push(SqlField.new(self, field_expression, field_alias)).last
  end

  # -----------------------------------------------------------
  def from(source, from_alias=source)
    @basetable = source
    @joins[from_alias] = SqlJoin.new(self, source, from_alias, :from)
  end
  
  # -----------------------------------------------------------
  def join(join_to, join_alias=join_to)
    @joins[join_alias] = SqlJoin.new(self, join_to, join_alias, :inner)
  end

  # -----------------------------------------------------------
  def outerjoin(join_to, join_alias=join_to)
    @joins[join_alias] = SqlJoin.new(self, join_to, join_alias, :outer)
  end

  # -----------------------------------------------------------
  def leftjoin(join_to, join_alias=join_to)
    @joins[join_alias] = SqlJoin.new(self, join_to, join_alias, :left)
  end

  # -----------------------------------------------------------
  def rightjoin(join_to, join_alias=join_to)
    @joins[join_alias] = SqlJoin.new(self, join_to, join_alias, :right)
  end

  # -----------------------------------------------------------
  def crossjoin(join_to, join_alias=join_to)
    @joins[join_alias] = SqlJoin.new(self, join_to, join_alias, :cross)
  end

  # -----------------------------------------------------------
  def where(condition)  ## ands/ors
    @wheres.last.conditions.push(condition)
    return @wheres.last
  end

  # -----------------------------------------------------------
  def begin_and()
    begin_and_or('and')
  end

  # -----------------------------------------------------------
  def begin_or()
    begin_and_or('or')
  end

  # -----------------------------------------------------------
  def begin_and_or(op)
    parent = @wheres.last
    child = SqlWhere.new(self, op)
    parent.conditions.push(child)
    @wheres.push(child)
  end

  # -----------------------------------------------------------
  def end_and()
    @wheres.pop()
  end

  # -----------------------------------------------------------
  def end_or()
    @wheres.pop()
  end

  # -----------------------------------------------------------
  def group()
  end
  
  # -----------------------------------------------------------
  def having()
  end

  # -----------------------------------------------------------
  def order()
  end

  # -----------------------------------------------------------
  def union()
  end

  # -----------------------------------------------------------
  def to_sql()
    sql = ''
  
    # fields
    sql = "select "
  
    #@fields.each { |field|
    #  sql += field.to_sql + ", "
    #}
  
    sql += @fields.join(', ') + ' '
  
    # joins
    @joins.each { |key, value|
      sql += value.to_sql + " "
    }
  
    # where
    where = @wheres.last.to_sql()
    if !where.empty?
      sql += 'where ' + where
    end
  
    # having
  
    # group
  
    # order
  
    return sql

  end

end

# -----------------------
class SqlField  < Object
  attr_accessor :sql, :alias, :expression, :table, :field_name

  # -----------------------------------------------------------
  def initialize(sql, field_expression, field_alias)
    super()
    @sql = sql
    @expression = field_expression
    set_table_and_field_name(field_expression)
    as(field_alias)
  end

  # -----------------------------------------------------------
  def as(field_alias)
    @alias = field_alias
  end

  # -----------------------------------------------------------
  def set_table_and_field_name(field_expression)
    dot_position = field_expression.rindex('.') # zero-based
    if dot_position && dot_position >= 0
      @table = @sql.joins[field_expression[0...dot_position]]
      @field_name = field_expression[dot_position..-1]
    else
      @table = nil
      @field_name = field_expression
    end
  end

  # -----------------------------------------------------------
  def to_sql
    if @alias != @expression
      return "#{@expression} as #{@alias}"
    else
      return "#{@expression}"
    end
  end

  # -----------------------------------------------------------
  def to_s
    return to_sql
  end

end

# -----------------------
class SqlJoin
  attr_accessor :sql, :alias, :source, :condition, :type

  # -----------------------------------------------------------
  def initialize(sql, join_to, join_alias, join_type)
    super()
    @sql = sql
    @source = join_to
    @alias = join_alias
    @type = join_type
    @condition = ""
    @join_sql = { :from => "from",
                  :inner => "inner join",
                  :outer => "full outer join",
                  :left => "left join",
                  :right => "right join",
                  :cross => "cross join" }
  end

  # -----------------------------------------------------------
  def on(join_condition)
    @condition = join_condition
    return self
  end

  # -----------------------------------------------------------
  def to_sql
  
    sql = "#{@join_sql[@type]} "
    if @source.class == Sql
      sql += " (#{@source.to_sql})"
    else
      sql += " #{@source}"
    end
    if @source!=@alias
      sql += " #{@alias}"
    end
    if !condition.empty?
      sql += " on #{@condition}"
    end
    return sql
  end
end

# -----------------------
class SqlWhere
  attr_accessor :sql, :op, :conditions, :insql

  # -----------------------------------------------------------
  def initialize(sql, op='and')
    @sql = sql
    @op = op
    @conditions = []
  end

  # -----------------------------------------------------------
  def in(insql)
    @insql = insql
  end

  # -----------------------------------------------------------
  def to_s()
    where_sql = ''
    if @conditions.count == 0
    elsif @conditions.count == 1
      where_sql = @conditions.join(' '+@op+' ')
    else
      where_sql = '(' + @conditions.join(' '+@op+' ') + ')'
    end
    if @insql
      where_sql += ' in (' + @insql.to_sql + ')'
    end
    return where_sql
  end

  # -----------------------------------------------------------
  def to_sql()
    return to_s()
  end
end

# -----------------------
class SqlOrder
  attr_accessor :field_alias, :descending
end

sqlo = sql {
  from( sql{
    from('plnact','pa')
    select('pa.plncomboid')
  }, 'a')
  
  join( sql{
    from('plncombo','pc')
    select('pc.plncomboid')
  }, 'c').on('c.plncomboid = a.plncomboid')
  
  select('c.plncomboid')
  
  where('c.plncomboid').in( sql{
    from('plncombo')
    select('plncomboid')
  })
  
  where('c.statid = 1')

}


=begin
  select('v.varietytag1')
  select('k.kindid', 'kindid')
  select('k.kind', 'kind')
  select('sum(pa.vol)').as('totalvol')
  select('sum(case when cp.calyearid = 7 then pa.vol else 0 end)').as('vol_7')
  select('sum(case when cp.calyearid = 8 then pa.vol else 0 end)').as('vol_8')
  select('sum(case when cp.calyearid = 9 then pa.vol else 0 end)').as('vol_9')
  select('sum(case when cp.calyearid = 10 then pa.vol else 0 end)').as('vol_10')

  begin_or
    where('cp.calyearid >= 7')
    where('cp.calyearid <= 10')
    
    begin_and
      where('p.prodid>=100')
      where('p.prodid<=200')
    end_and  
  end_or
  
  where('pc.statid=1')
=end


=begin
  from('plnact', 'pa')
  join('calperiod', 'cp').on('cp.calperiodid = pa.calperiodid')
  join('plncombo', 'pc').on('pc.plncomboid = pa.plncomboid')
  join('prods', 'p').on('p.prodid = pc.prodid')
  join('kinds', 'k').on('k.kindid = p.kindid')
  join('varietys').as('v').on('v.varietyid = p.varietyid')

  select('v.varietytag1')
  select('k.kindid', 'kindid')
  select('k.kind', 'kind')
  select('sum(pa.vol)').as('totalvol')
  select('sum(case when cp.calyearid = 7 then pa.vol else 0 end)').as('vol_7')
  select('sum(case when cp.calyearid = 8 then pa.vol else 0 end)').as('vol_8')
  select('sum(case when cp.calyearid = 9 then pa.vol else 0 end)').as('vol_9')
  select('sum(case when cp.calyearid = 10 then pa.vol else 0 end)').as('vol_10')

  where('cp.calyearid >= 7')
  where('cp.calperiodid <= 10')
  
  begin_or()
      where('pa.vol > 0')
      where('pa.price0 > 0')
  end_or()
    
  group('v.varietytag1')
  group('k.kindid')
  group('k.kind')

  order('totalvol')
=end



