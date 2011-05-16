require 'service_layer/command'
require 'service_layer/service'

module ServiceLayer
  class Error < StandardError
    attr_reader :object
    def initialize(object = nil, msg = nil)
      super(msg)
      @object = object
    end
  end

end
