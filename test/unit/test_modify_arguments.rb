#
# (c) Christoph Heindl, 2010
# http://cheind.wordpress.com
#

require 'test/unit'

require 'rcapture'

class TestModifyArguments < Test::Unit::TestCase
  
  def test_capture_pre
    x = []
    x.extend(RCapture::Interceptable)
    
    inc = Proc.new do |ci|
      ci.a[0] += 1
    end
    
    dec = Proc.new do |ci|
      ci.a[0] -= 1
    end
    
    mul = Proc.new do |ci|
      ci.a[0] *= 2
    end
    
    x.capture_pre :methods => :<<, &inc
    x.capture_pre :methods => :<<, &mul
    x.capture_pre :methods => :<<, &inc
    x.capture_pre :methods => :<<, &dec
    x.capture_pre :methods => :<<, &dec
    
    x << 2 << 4
    assert_equal([3,7], x) 
  end
  
  def test_capture_post
    x = []
    x.extend(RCapture::Interceptable)
    
    inc = Proc.new do |ci|
      ci.r += 1
    end
    
    dec = Proc.new do |ci|
      ci.r -= 1
    end
    
    mul = Proc.new do |ci|
      ci.r *= 2
    end
    
    x.capture_post :methods => :[], &inc
    x.capture_post :methods => :[], &mul
    x.capture_post :methods => :[], &inc
    x.capture_post :methods => :[], &dec
    x.capture_post :methods => :[], &dec
    
    x << 1 << 4
    
    assert_equal(3, x[0])
    assert_equal(9, x[1])
  end
  
  def test_capture_pre_post
    x = []
    x.extend(RCapture::Interceptable)
    
    inc = Proc.new do |ci|
      ci.a[0] += 1
    end
    
    mul = Proc.new do |ci|
      ci.r *= 2
    end
    
    x.capture_pre :methods => :<<, &inc
    x.capture_post :methods => :[], &mul
    
    x << 2 << 7
    assert_equal(6, x[0])
    assert_equal(16, x[1])
  end
  
  def test_capture_pre_return
    x = []
    x.extend(RCapture::Interceptable)
    
    filter = Proc.new do |ci|
      ci.r = ci.s
      ci.p = ci.a[0] % 2 == 0
    end
    
    x.capture_pre :methods => :<<, &filter
    x << 2 << 8 << 7 << 6 << 5
    assert_equal([2,8,6], x)
  end
end
