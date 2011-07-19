
require "test/unit"
require File.dirname(__FILE__) + '/../rb/toolbox.rb'

# ---------------------------
class TestSql < Test::Unit::TestCase
  include Toolbox

  # ---------------------------
  def setup
    @test = QuickClass.new
  end#def
  
  # ---------------------------
  def test_props_are_not_assigned
    assert_equal(@test.string,"")
    assert_equal(@test.number,0)
    assert_equal(@test.boolean,false)
  end#def

  # ---------------------------
  def test_props_get_assigned
    loadprops!('string="test" number="10" boolean="true"', @test)
    assert_equal(@test.number,10)
    assert_equal(@test.boolean,true)
    assert_equal(@test.string,"test")
  end#def

  # ---------------------------
  def test_loadprops_works_when_included_in_class
    @test.loadprops!('string="test" number="10" boolean="true"')
    assert_equal(@test.number,10)
    assert_equal(@test.boolean,true)
    assert_equal(@test.string,"test")
  end
  
end#class

# ---------------------------
class QuickClass < Object
  include Toolbox
  
  attr_accessor :string, :number, :date, :datetime, :boolean  
  # ---------------------------
  def initialize()
    @string = ""
    @number = 0
    @boolean = false
  end
  # ---------------------------
  def to_s    
    string = "string=#{@string}; number=#{@number}; boolean=#{@boolean};"
    return string
  end
end

