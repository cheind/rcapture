#
# (c) Christoph Heindl, 2010
# http://cheind.wordpress.com
#

require 'test/unit'

require 'rcapture'
include RCapture

class X
  include Interceptable
  
  def initialize(name)
    @name = name
  end
  
  def say_hello
    puts "Hello, #{@name}!"
  end
end

class Y < X
  def initialize
    super("y")
  end
end

class AcceptanceNewWithBlock < Test::Unit::TestCase
  
  def test_new_with_block
    
    X.capture_post :class_methods => :new do |ci|
      ci.b.call(ci.r) if ci.b
    end
    
    x = X.new("as")
    assert_instance_of(X, x)
    
    X.new("christoph") do |x|
      assert_instance_of(X, x)
      x.say_hello
    end
    
    Y.new do |y|
      assert_instance_of(Y, y)
      y.say_hello
    end
    
  end
    
end