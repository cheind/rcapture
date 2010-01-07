  require 'rcapture'
  include RCapture

  # Closed polygon
  class Polygon
    include Interceptable
    def vertices; self.edges; end
  end

  # Triangle
  class Triangle < Polygon
    def edges; 3; end
  end

  # Degenerate polygon
  class Digon < Polygon
    def edges; 1; end
    def vertices; 2; end
  end

  # Four sided polygon
  class Quadliteral < Polygon
    def edges; 4; end
    def vertices; super; end
  end
  
  called = 0
  Polygon.capture :methods => :vertices do
    called += 1
  end
  
  Triangle.new.vertices # +1
  Digon.new.vertices # -
  Quadliteral.new.vertices # +1
  
  p called #=> 2