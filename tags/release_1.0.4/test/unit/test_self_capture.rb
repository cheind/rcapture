#
# (c) Christoph Heindl, 2010
# http://cheind.wordpress.com
#

require 'test/unit'

require 'test/unit/testee'


class TestSelfInterception < Test::Unit::TestCase
  
  def test_self_intercept
    count_class = 0
    Testee.capture :class_methods => [:capture, :capture_pre, :capture_post] do
      count_class += 1
    end
    
    t = Testee.new
    count_obj = 0
    t.capture :methods => [:capture, :capture_pre, :capture_post] do
      count_obj += 1
    end
    
    
    assert_equal(0, count_class)
    assert_equal(0, count_obj)
    
    Testee.capture :methods => :x do
    end
    
    t.capture :methods => :x do
    end
    t.capture_pre :methods => :y= do
    end
    
    assert_equal(1, count_class)
    assert_equal(2, count_obj)
  end
end
