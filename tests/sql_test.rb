
require "../sql/sql.rb"
require "test/unit"

# ---------------------------
class TestSql < Test::Unit::TestCase
  
  # ---------------------------
  def setup
    @sql = Sql.new
  end#def
  
  # ---------------------------
  def test_init
    assert_not_equal(@sql,nil)
  end#def
  
  # ---------------------------
  def test_sql_select
    sql = Sql.new{
      from('test')
      select('*')
    }
  end
  
end#class