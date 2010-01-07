#
# (c) Christoph Heindl, 2010
# http://cheind.wordpress.com
#

require 'test/unit'

require 'rcapture'
include RCapture

class Fixnum
  include Interceptable
end

class AcceptancePolicies < Test::Unit::TestCase
    
  def test_clamping_policy
    
    min = 0
    max = 1
    clamp_policy = Proc.new do |ci|
      ci.a.collect! do |v|
        if v.instance_of?(Fixnum)
          (v < min) ? min : ((v > max) ?  max : v)
        else
          v
        end
      end
    end
    
    Fixnum.capture_pre :methods => [:+,:-], &clamp_policy
    
    assert_equal(1, 0+1)
    assert_equal(1, 0+4)
    assert_equal(2, 0+4+2-30+3)
  end
end