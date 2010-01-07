
module RCapture

  # = Introduction
  # Interceptable is a module mixin to enrich the receiver with capturing capatibilities.
  #
  # It can be used at a class scope:
  #
  #  class Array
  #    include RCapture::Interceptable
  #  end
  #
  # This will provide the methods +capture+, +capture_pre+, and +capture_post+.
  # at class and instance level:
  #
  #  Array.capture :methods => :push do
  #    puts 'pushed'
  #  end
  #
  # will affect all instances of Array. On the other hand
  #
  #  a = []
  #  a.capture :methods => :push do
  #    puts 'pushed'
  #  end
  #
  # will affect only the instance +a+.
  #
  # Instances can be extended by Interceptable to provide capturing capatibilities
  # for the selected instance only:
  #
  #  a = []
  #  a.extend(RCapture::Interceptable)
  #  a.capture :methods => :push do
  #    puts 'pushed'
  #  end
  module Interceptable
  
    module ClassMethods # :nodoc:
      def capture(args, &callback)
        RCapture::Internal.capture_post(self, args, &callback)
      end
      alias_method :capture_post, :capture
      
      def capture_pre(args, &callback)
        RCapture::Internal.capture_pre(self, args, &callback)
      end
    end
    
    def self.included(klass) # :nodoc:
      klass.extend(Interceptable::ClassMethods)
    end
    
    # Perform a post-capture on the given class/instance.
    #
    # === Arguments
    # args:: A hash of options. The following are recognized
    #        [:methods] Instance methods to capture. Either a single method name/symbol or
    #                   and array of names/symbols.
    #        [:class_methods] Class methods to capture. Either a single method name/symbol or
    #                         and array of names/symbols.
    # callback:: The block to be invoked after captured method was invoked. The callback will be given
    #            an instance of CapturedInfo.
    def capture_post(args, &callback)
      RCapture::Internal.capture_post(
        RCapture::Internal.singleton_class(self), 
        args, 
        &callback
      )
    end
    alias_method :capture, :capture_post
    
    # Perform a pre-capture on the given class/instance.
    #
    # === Arguments
    # args:: A hash of options. The following are recognized
    #        [:methods] Instance methods to capture. Either a single method name/symbol or
    #                   and array of names/symbols.
    #        [:class_methods] Class methods to capture. Either a single method name/symbol or
    #                         and array of names/symbols.
    # callback:: The block to be invoked before the captured method is invoked. The callback will be given
    #            an instance of CapturedInfo.
    def capture_pre(args, &callback)
      RCapture::Internal.capture_pre(
        RCapture::Internal.singleton_class(self), 
        args, 
        &callback
      )
    end
    
  end
end

