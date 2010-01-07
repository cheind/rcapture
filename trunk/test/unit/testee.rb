#
# (c) Christoph Heindl, 2010
# http://cheind.wordpress.com
#

require 'rcapture'

class Testee
  include RCapture::Interceptable
  
  attr_reader :x
  attr_accessor :y
  
  def initialize
    @x = :x; @y = :y
  end
  
  def Testee.z
    :z
  end
  
  private
  
  def prv
  end
end
  
