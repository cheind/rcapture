#
# (c) Christoph Heindl, 2010
# http://cheind.wordpress.com
#

require 'test/unit'
require 'test/unit/testee'

class TestReturnValue < Test::Unit::TestCase
   
  def test_correct_return
    t = Testee.new
    t.capture_pre :methods => :x do
    end
    t.capture_post :methods => :x do
    end
    
    assert_equal(:x, t.x)
  end
  
  def test_modify_return
    t = Testee.new
    t.capture_post :methods => :y do |ci|
      ci.return = :yy
    end
    assert_equal(:yy, t.y)
  end
  
  def test_modify_argument
    t = Testee.new
    t.capture_pre :methods => :y= do |ci|
      ci.a[0] = :yyy
    end
    
    t.y = :abc
    assert_equal(:yyy, t.y)
  end
end
