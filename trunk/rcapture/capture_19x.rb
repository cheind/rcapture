
module RCapture

  module Internal
  
    # Pre-capture single method.
    # This version is used on Ruby 1.9.x where define_method
    # allows for block arguments
    def Internal.capture_single_pre(klass, method, additional_args, &callback)
      prev = klass.instance_method(method)
      # http://eigenclass.org/hiki/Changes+in+Ruby+1.9#l32
      is_private = klass.private_instance_methods.include?(method)
      
      klass.class_eval do
        # http://eigenclass.org/hiki/Changes+in+Ruby+1.9#l11
        define_method "#{method}" do |*args, &b|
          status = CaptureStatus.current
          call_prev = true; alt_ret = nil
          if status.on?
            status.use(false) do
              ci = CapturedInfo.current
              ci.fill(args, self, method, b)
              callback.call(ci)
              alt_ret = ci.return
              call_prev = ci.predicate
            end
          end
          if call_prev
            prev.bind(self).call(*args, &b)
          else
            alt_ret
          end
        end
        private "#{method}" if is_private
      end
    end
    
    # Post-capture single method.
    # This version is used on Ruby 1.9.x where define_method
    # allows for block arguments
    def Internal.capture_single_post(klass, method, additional_args, &callback)
      prev = klass.instance_method(method)
      # http://eigenclass.org/hiki/Changes+in+Ruby+1.9#l32
      is_private = klass.private_instance_methods.include?(method)
      
      klass.class_eval do
        define_method "#{method}" do |*args, &b|
          ret = prev.bind(self).call(*args, &b)
          status = CaptureStatus.current
          if status.on?
            status.use(false) do
              ci = CapturedInfo.current
              ci.fill(args, self, method, b, ret)
              callback.call(ci)
              ret = ci.return
            end
          end
          ret
        end
        private "#{method}" if is_private
      end   
    end
  end
end

