#
# (c) Christoph Heindl, 2010
# http://cheind.wordpress.com
#

require 'test/unit'

require 'rcapture'
include RCapture

# Closed polygon dummy
class Polygon
  include Interceptable
  def vertices
    self.edges
  end
end

class Triangle < Polygon
  def edges
    3
  end
end

 # Degenerate Polygon
class Digon < Polygon
  def edges
    1
  end
  
  def vertices
    2
  end
end

class Quadliteral < Polygon
  def edges
    4
  end
  
  def vertices
    super
  end
end

class AcceptanceInheritance < Test::Unit::TestCase 
  def test_inheritance
    called = 0
    Polygon.capture :methods => :vertices do |ci|
      called += 1
    end
    
    assert_equal(3, Triangle.new.vertices)
    assert_equal(1, called)
    
    assert_equal(2, Digon.new.vertices)
    assert_equal(1, called)
    assert_equal(4, Quadliteral.new.vertices)
    assert_equal(2, called)
  end
end