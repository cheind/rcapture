
module RCapture

  module Internal
  
    # Pre-capture single method.
    # This version is used on Ruby 1.8.x where define_method
    # does not allow for block arguments. See http://tinyurl.com/yczowjx
    def Internal.capture_single_pre(klass, method, additional_args, &callback)
      prev = klass.instance_method(method)
      id = prev.object_id
      is_private = klass.private_instance_methods.include?(method.to_s)
      
      klass.class_eval do
        define_method "#{method}_#{id}_" do |b, *args|
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
        private "#{method}_#{id}_"
      end
      
      klass.class_eval <<-EOF 
        def #{method} *args, &block
          self.send "#{method}_#{id}_", block, *args
        end
        private "#{method}" if #{is_private}
      EOF
    end
    
    # Post-capture single method.
    # This version is used on Ruby 1.8.x where define_method
    # does not allow for block arguments. See http://tinyurl.com/yczowjx
    def Internal.capture_single_post(klass, method, additional_args, &callback)
      prev = klass.instance_method(method)
      id = prev.object_id
      is_private = klass.private_instance_methods.include?(method.to_s)
      
      klass.class_eval do
        define_method "#{method}_#{id}_" do |b, *args|
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
        private "#{method}_#{id}_"
      end
   
      klass.class_eval <<-EOF 
        def #{method} *args, &block
          self.send "#{method}_#{id}_", block, *args
        end
        private "#{method}" if #{is_private}
      EOF
    end
  end
end

