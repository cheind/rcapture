  require 'rcapture'
  
  class Fixnum
    include RCapture::Interceptable
  end
  
  op_count = 0
  Fixnum.capture :methods => :+ do |cs|
    # Here we use Fixnum#+ inside the callback.
    # RCapture takes special care that anything that
    # happens inside a callback remains capture-free.
    op_count = op_count + 1
  end
  
  x = 1 + 1 + 2 + 3
  p op_count #=> 3