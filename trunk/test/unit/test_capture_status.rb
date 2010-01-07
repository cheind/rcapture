#
# (c) Christoph Heindl, 2010
# http://cheind.wordpress.com
#

require 'test/unit'

require 'thread'
require 'rcapture'
include RCapture

class TestCaptureStatus < Test::Unit::TestCase
    
  def test_status
    s = CaptureStatus.new(true)
    assert(s.on?)
    s.set(true); assert(s.on?)
    s.set(true); assert(s.on?)
    s.set(false); assert(s.off?)
    s.set(false); assert(s.off?)
    s.restore; assert(s.off?)
    s.restore; assert(s.on?)
    s.restore; assert(s.on?)
    s.restore; assert(s.on?)
    s.restore; assert(s.on?)
  end
  
  def calc(status)
    return true if status.on?
    return false if status.off?
  end
  
  def test_scope
    s = CaptureStatus.new(true)
    ret = s.use(false) do
      self.calc(s)
    end
    assert(!ret)
    assert(self.calc(s))
    ret = s.use(true) do
      self.calc(s)
    end
    assert(ret)
  end
  
  def test_thread_local
    a_cs = nil
    a_cs2 = nil
    b_cs = nil
    
    a = Thread.new do 
      a_cs = CaptureStatus.current
      a_cs2 = CaptureStatus.current
    end
    
    b = Thread.new do 
      b_cs = CaptureStatus.current
    end
    
    a.join
    b.join
    
    assert_same(a_cs, a_cs2)
    assert_not_same(a_cs, b_cs)
  end
end