  require 'rcapture'
  require 'thread'
  
  # Will keep track of Enumberable#inject results
  inject_results = []
  m = Mutex.new
  
  module Enumerable
    include RCapture::Interceptable
  end
  
  Enumerable.capture :methods => :inject do |cs|
    # Callbacks can be invoked from multiple threads.
    # So we need to synchronize access to shared resources.
    m.synchronize do
      inject_results << cs.return
    end
  end
  
  array = []
  10000.times {array << rand(100)}
  
  threads = []
  5.times do
    t = Thread.new do
      sum = array.inject(0) {|memo, e| memo + e}
    end
    threads << t
  end
  threads.each {|t| t.join }
  
  p inject_results #=> [493311, 493311, 493311, 493311, 493311] or similar