#
# (c) Christoph Heindl, 2010
# http://cheind.wordpress.com
#

require 'test/unit'

require 'test/unit/testee'
require 'thread'

class TestThreading < Test::Unit::TestCase
  
  def spawn_thread(nr)
    Thread.new do 
      t = Testee.new
      nr.times do
        t.x
      end
    end
  end
  
  def test_multiple_threads
    count = 0
    m = Mutex.new
    
    Testee.capture :methods => :x do
      m.synchronize do # ouch! that mutex will slow down everything radically
        count += 1
      end
    end
    
    threads = []
    5.times do 
      threads << spawn_thread(10000)
    end
    threads.each do |t|
      t.join
    end
    
    assert_equal(count, 10000 * 5)
  end
  
  def test_status_multiple_threads
    
    threads = []
    count = 0
    m = Mutex.new
    RCapture::Internal.capture_post(Fixnum, :methods => :+) do
      m.synchronize do
        count = count + 1 # notice that op + has been captured
      end
    end
    
    5.times do
      threads << Thread.new do
        10000.times do
          x = 1+1
        end
      end
    end
    
    threads.each do |t|
      t.join
    end
    
    assert_equal(10000*5, count)
  end
  
end
