  require 'rcapture'

  # This array will only accept even numbers
  x = []
  x.extend(RCapture::Interceptable)
  
  even_filter = Proc.new do |ci|
    # Define the predicate that must evaluate to true
    # in order to call the captured method
    ci.predicate = (ci.args.first % 2 == 0)
    
    # In case the predicate evaluates to false you
    # can use the return property to control
    # what is returned from the captured method instead
    # Insertion to array returns the array itself:
    ci.return = ci.sender
  end
  
  x.capture_pre :methods => [:<<, :push], &even_filter
    
  x << 2 << 3 << 4 << 5 << 6
  x.push(7).push(8)
  p x
  #=> [2,4,6,8]