#
# (c) Christoph Heindl, 2010
# http://cheind.wordpress.com
#

require 'test/unit'

require 'rcapture'
include RCapture

class AcceptanceModifyArguments < Test::Unit::TestCase
    
  def test_pre
    x = Array.new
    x.extend(Interceptable)
    x.capture_pre :methods => :<< do |ci|
      ci.a[0] += 1
    end
   
    x << 1 << 2
    assert_equal([2, 3], x)
  end
  
  def test_pre_return
    x = Array.new
    x.extend(Interceptable)
    x.capture_pre :methods => :<< do |ci|
      ci.p = ci.s.length < 2
      ci.r = ci.s
    end
    
    x << 1 << 2 << 3 << 4
    assert_equal([1, 2], x)
    
  end
  
  def test_post_return
    x = Array.new
    x.extend(Interceptable)
    x.capture_post :methods => :length do |ci|
      ci.r -= 1
    end
    
    x << 1 << 2
    assert_equal(1, x.length)
    x << 1 << 2
    assert_equal(3, x.length)
    
  end
end