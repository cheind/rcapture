  require 'rcapture'

  # Enrich Math module
  module Math
    include RCapture::Interceptable
  end
  
  Math.capture_pre :class_methods => [:cos, :acos, :sin, :asin] do
    puts "Hello Trigonometry!"
  end

  Math.cos(0)
  
  #=> Hello Trigonometry!