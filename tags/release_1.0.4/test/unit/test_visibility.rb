#
# (c) Christoph Heindl, 2010
# http://cheind.wordpress.com
#

require 'test/unit'

require 'test/unit/testee'

class TestVisibility < Test::Unit::TestCase
  
  def test_public
    t = Testee.new
    t.capture :methods => :x do
    end
    sym = "x"
    sym = :x if RUBY_VERSION >= "1.9"
    assert(RCapture::Internal.singleton_class(t).public_instance_methods.include?(sym))
  end
  
  def test_private
    t = Testee.new
    t.capture :methods => :prv do
    end
    sym = "prv"
    sym = :prv if RUBY_VERSION >= "1.9"
    assert(RCapture::Internal.singleton_class(t).private_instance_methods.include?(sym))
  end
end
