  require 'rcapture'
  include RCapture

  class X
    include Interceptable
    def initialize(name); @name = name; end
    def say_hello; puts "Hello, #{@name}!"; end
  end

  class Y < X
    def initialize; super("Y"); end
  end

  X.capture :class_methods => :new do |ci|
    ci.block.call(ci.return) if ci.block
  end

  # Now you can use X and Y as if it supports
  # blocks
  x = X.new("Christoph") do |x|
    x.say_hello #=> "Hello, Christoph!"
  end

  y = Y.new do |y|
    y.say_hello #=> "Hello, Y!"
  end

  # Or leaf the block argument away
  x = X.new("Christoph")
  y = Y.new