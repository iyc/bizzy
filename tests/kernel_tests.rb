
require "test/unit"
require File.dirname(__FILE__) + '/../toolbox.rb'

# ---------------------------------------
class KernelTest < Test::Unit::TestCase

  # ---------------------------------------
  def test_should_return_true
    assert_equal true, Boolean('true')
    assert_equal true, Boolean('TrUe')
    assert_equal true, Boolean(true)
  end

  # ---------------------------------------
  def test_should_return_false
    assert_equal false, Boolean(nil)
    assert_equal false, Boolean('false')
    assert_equal false, Boolean('FaLsE')
    assert_equal false, Boolean(false)
  end

  # ---------------------------------------
  def test_should_raise_exception
    assert_raise(ArgumentError) { Boolean('true ') }
    assert_raise(ArgumentError) { Boolean(' true') }
    assert_raise(ArgumentError) { Boolean(' true ') }
    assert_raise(ArgumentError) { Boolean('false ') }
    assert_raise(ArgumentError) { Boolean(' false') }
    assert_raise(ArgumentError) { Boolean(' false ') }
    assert_raise(ArgumentError) { Boolean('BLAH') }
    assert_raise(ArgumentError) { Boolean(1) }
  end

end