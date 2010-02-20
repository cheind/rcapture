#
# (c) Christoph Heindl, 2010
# http://cheind.wordpress.com
#

require 'test/unit'

require 'rcapture'

class Array
  include RCapture::Interceptable
end

class TestAcceptanceArrray < Test::Unit::TestCase
    
  def test_array
    op_count = 0
    a = Array.new  
    
    a.capture :methods => [:push, :<<] do |ci|
      puts "intercepted"
    end
    
    Array.capture_pre :class_methods => :new  do |ci|
      p "new called"
    end
    
    r = Array.new(3)
    
    a << 1 << 2
    [] << 1
    p a
    
    
  end
end