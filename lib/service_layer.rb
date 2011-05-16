require 'service_layer/command'
require 'service_layer/service'

module ServiceLayer
  class Error < StandardError
    attr_reader :object
    def initialize(msg = nil, object = nil)
      super(msg)
      @object = object
    end
  end

  class PersistError < Error ; end
end
