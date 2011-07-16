
require "../sql/sql.rb"
require "test/unit"

# ---------------------------
class TestSql < Test::Unit::TestCase
  
  # ---------------------------
  def setup
  end#def
  
  # ---------------------------
  def test_init
    sql = Sql.new
    assert_equal(sql,sql)
    
  end#def
  
end#class