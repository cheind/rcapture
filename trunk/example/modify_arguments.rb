  require 'rcapture'

  # Enrich single instance
  x = []
  x.extend(RCapture::Interceptable)
  
  # Define procs that will modify the input arguments
  inc = Proc.new { |ci| ci.args[0] += 1 }
  dec = Proc.new { |ci| ci.args[0] -= 1 }
  mul = Proc.new { |ci| ci.args[0] *= 2 }

  # Capture ':<<' multiple times.
  x.capture_pre :methods => :<<, &inc
  x.capture_pre :methods => :<<, &mul
  x.capture_pre :methods => :<<, &inc
  x.capture_pre :methods => :<<, &dec
  x.capture_pre :methods => :<<, &dec
  
  x << 2 << 4
  p x
  #=> [3,7]
  
  # Similarily, you can modify return values
  y = []
  y.extend(RCapture::Interceptable)
  
  inc = Proc.new { |ci| ci.return += 1 }
  dec = Proc.new { |ci| ci.return -= 1 }
  mul = Proc.new { |ci| ci.return *= 2 }
  
  y.capture_post :methods => :[], &inc
  y.capture_post :methods => :[], &mul
  y.capture_post :methods => :[], &inc
  y.capture_post :methods => :[], &dec
  y.capture_post :methods => :[], &dec
  
  y << 1 << 4
  p y[0] #=> 3
  p y[1] #=> 9