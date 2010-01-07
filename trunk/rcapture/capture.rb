
module RCapture
  
  # RCapture internal methods
  module Internal # :nodoc:
  
    # Perform a pre-capture on the given class.
    def Internal.capture_pre(klass, args, &callback)
      CaptureStatus.current.use(false) do
        RCapture::Internal.capture(klass, { :type => :pre }.merge(args), &callback)
      end
    end
    
    # Perform a post-capture on the given class.
    def Internal.capture_post(klass, args, &callback)
      CaptureStatus.current.use(false) do
        RCapture::Internal.capture(klass, { :type => :post }.merge(args), &callback)
      end
    end

    # Dispatches to internal methods by arguments provided.
    def Internal.capture(klass, args, &callback)
      args = { :methods => [], :class_methods => [] }.merge(args)
      
      RCapture::Internal.capture_methods(
        klass,
        args[:methods].to_a,
        args,
        &callback
      )
    
      RCapture::Internal.capture_methods(
        RCapture::Internal.singleton_class(klass),
        args[:class_methods].to_a,
        args,
        &callback
      )
    end

    # Iterate over each method and install capturing code
    def Internal.capture_methods(klass, methods, additional_args, &callback)
      type = additional_args[:type]
      methods.each do |m|
        RCapture::Internal.capture_single_method(klass, m.to_sym, type, additional_args, &callback)
      end
    end
    
    # Install capturing code at single method.
    # Dispatches based on the type of capturing (pre/post)
    def Internal.capture_single_method(klass, method, type, additional_args, &callback)
      case type
        when :post
          RCapture::Internal.capture_single_post(klass, method, additional_args, &callback)
        when :pre
          RCapture::Internal.capture_single_pre(klass, method, additional_args, &callback)
      end
    end
    
  end
end