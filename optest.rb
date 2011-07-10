
class Sql
  attr_accessor :var

  def =~(var)
    puts var
    #Sql.new(&block)
  end
  
  def test2(var)
    puts var
  end

  def test()
    test2('sgod')
    Sql::=~('dogs')
    #Sql.>{
    #  puts 'dogs'
    #}
  end
  
end

Sql.new.test
#Sql> {
#  puts 'cats'
#}

