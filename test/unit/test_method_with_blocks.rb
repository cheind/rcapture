#
# (c) Christoph Heindl, 2010
# http://cheind.wordpress.com
#

require 'test/unit'

require 'rcapture'

class Array
  include RCapture::Interceptable
end

class TestMethodWithBlocks < Test::Unit::TestCase
  
  def test_array
    count = 0
    Array.capture :methods => :each do
      count += 1
    end
    
    x = []
    x << 1 << 2
    sum = 0
    x.each do |v|
      sum += v
    end
    
    assert_equal(1, count)
    assert_equal(3, sum)
  end
end
