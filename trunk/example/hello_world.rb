  require 'rcapture'

  # Enrich Array class.
  class Array
    include RCapture::Interceptable
  end

  # Install a hook at insertion methods of Array.
  # Calling capture methods at class level will capture
  # insertions from all instances of Array.
  Array.capture_pre :methods => [:<<, :push] do |cs|
    puts "'#{cs.method}' will be called with #{cs.args.first}"
  end

  [] << 1 << 2
  [].push :hello

  # Installing a hook on instance level will
  # affect only that single instance
  a = []
  a.capture_post :methods => :length do |cs|
    puts "Length of 'a' is #{cs.return}"
  end

  a << 1
  a.length

  # Any other array will not be affected
  [].length

  #=> '<<' was called with 1!
  #=> '<<' was called with 2!
  #=> 'push' was called with hello!
  #=> '<<' was called with 1!
  #=> Length of 'a' is 1
