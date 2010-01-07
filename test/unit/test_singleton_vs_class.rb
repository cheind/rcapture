#
# (c) Christoph Heindl, 2010
# http://cheind.wordpress.com
#

require 'test/unit'

require 'rcapture'

class Array
  include RCapture::Interceptable
end

class TestSingletonVsClass < Test::Unit::TestCase
  
  def test_singleton_class
    count = 0
    ccount = 0
    Array.capture :methods => :<< do
      count += 1
    end
    
    x = []
    x.capture :methods => :<< do
      ccount += 1
    end
    
    x << 1
    assert_equal(1, count)
    assert_equal(1, ccount)
    
    y = []
    y << 2
    assert_equal(2, count)
    assert_equal(1, ccount)
  end
end
