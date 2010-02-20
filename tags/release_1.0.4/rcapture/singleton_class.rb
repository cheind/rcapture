
module RCapture
  module Internal
    # Access singleton class of given object
    def Internal.singleton_class(t)
      class << t
        self
      end
    end
  end  
end

