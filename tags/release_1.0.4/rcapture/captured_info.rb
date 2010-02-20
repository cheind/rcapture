require 'thread'

module RCapture

  # Holds captured method information and acts as a communicator
  # between callback and RCapture.
  #
  # === Post Capture
  # When called from a method previously captured by +capture_post+,
  # the following meaning holds true:
  # args:: Array of input arguments passed to the method.
  # sender:: Instance the method was called on.
  # method:: Symbol of method called.
  # return:: Value returned by method. When modified, the modified value is
  #          returned from the method.
  # block:: Block passed to method or nil.
  # predicate:: Unused.
  #
  # === Pre Capture
  # When called from a method that was previously captured by +capture_pre+,
  # the following meaning holds true:
  # args:: Array of input arguments passed to the method. Modifyable.
  # sender:: Instance the method was called on.
  # method:: Symbol of method called.
  # block:: Block passed to method or nil.
  # predicate:: Initially true. If set to false the captured method will not be invoked.
  # return:: Initially nil. If +predicate+ is false, then the value of +return+ is returned
  #          from the method.
  #
  class CapturedInfo
    attr_accessor :args
    attr_accessor :sender
    attr_accessor :method
    attr_accessor :return
    attr_accessor :predicate
    attr_accessor :block
    
    # Access thread-local CapturedInfo variable
    def CapturedInfo.current
      Thread.current[:captured_info] ||= CapturedInfo.new
    end
    
    # Fill with values
    def fill(args, sender, method, block = nil, ret = nil)
      @args = args
      @sender = sender
      @method = method
      @return = ret
      @block = block
      @predicate = true
    end
    
    alias_method :a, :args
    alias_method :s, :sender
    alias_method :m, :method
    alias_method :r, :return
    alias_method :r=, :return=
    alias_method :b, :block
    alias_method :p, :predicate
    alias_method :p=, :predicate=
  end  
end