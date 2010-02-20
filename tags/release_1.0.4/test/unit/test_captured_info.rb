#
# (c) Christoph Heindl, 2010
# http://cheind.wordpress.com
#

require 'test/unit'

require 'rcapture'
include RCapture

class TestCapturedInfo < Test::Unit::TestCase
    
  def test_info
    ci = CapturedInfo.new
    ci.fill([1,2], self, :test_info)
    
    assert_equal([1,2], ci.args)
    assert_same(self, ci.sender)
    assert_same(:test_info, ci.method)
    assert_equal(nil, ci.block)
    assert_equal(nil, ci.return)
    assert(ci.predicate)    
  end
  
  def test_aliases
    ci = CapturedInfo.new
    ci.fill([1,2], self, :test_info)
    
    assert_equal([1,2], ci.a)
    assert_same(self, ci.s)
    assert_same(:test_info, ci.m)
    assert_equal(nil, ci.b)
    assert_equal(nil, ci.r)
    assert(ci.p)    
    
    ci.r = 4
    ci.p = false
    
    assert_equal(4, ci.r)
    assert(!ci.p)
  end
  
  def test_pre_capture
    a = []
    a.extend(Interceptable)
    a.capture_pre :methods => :<< do |cs|
      assert_equal([1], cs.a)
      assert_same(a, cs.s)
      assert_same(:<<, cs.m)
      assert_nil(cs.b)
      assert(cs.p)
      assert_nil(cs.r)
      cs.r = :ok
      cs.p = false
    end
    
    assert_equal(:ok, a << 1)
    assert_equal([], a)
    
    proc = Proc.new do |v|
    end
    
    a.capture_pre :methods => :each do |cs|
      assert_same(proc, cs.b)
    end
    a.each &proc
  end
  
  def test_post_capture
    a = []
    a.extend(Interceptable)
    a.capture_post :methods => :<< do |cs|
      assert_equal([1], cs.a)
      assert_same(a, cs.s)
      assert_same(:<<, cs.m)
      assert_same(a, cs.r)
      assert_nil(cs.b)
      assert(cs.p)
      cs.r = :ok
    end
    
    assert_equal(:ok, a << 1)
    assert_equal([1], a)
    
    proc = Proc.new do |v|
    end
    
    a.capture_pre :methods => :each do |cs|
      assert_same(proc, cs.b)
    end
    a.each &proc    
  end
end