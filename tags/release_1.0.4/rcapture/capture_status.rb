require 'thread'

module RCapture

  # Stack-based boolean enabled/disabled status.
  # CaptureStatus is used to disable capturing from
  # within callbacks which could otherwise lead to
  # infinite recursion or undesired results.
  class CaptureStatus
    
    def initialize(value = true)
      @status = value
      @stack = []
    end
    
    # Access thread-local capture status variable
    def CaptureStatus.current
      Thread.current[:capture_status] ||= CaptureStatus.new(true)
    end
    
    # Status is set to +value+ while operating on the block.
    def use(value)
      begin
        self.set(value)
        yield
      ensure
        self.restore
      end
    end
    
    # Set/push new status
    def set(value)
      @stack.unshift @status
      @status = value
    end
    
    # Query status
    def on?
      @status
    end
    
    # Query status
    def off?
      !@status
    end
    
    # Pop status from stack
    def restore
      @status = @stack.shift if @stack.size > 0
    end
  end
  
end