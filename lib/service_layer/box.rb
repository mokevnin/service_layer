module ServiceLayer
  class Box
    cattr_accessor :exceptions
    @@exceptions = {}

    def initialize(service, objects, &block)
      @service = service
      @objects = objects
      @block   = block
    end

    def method_missing(method, *args, &block)
      @service.send method, *args, &block
    end

    def execute
      @block.call if @block
      @objects[:object]
    rescue StandardError => e
      raise e if e.kind_of?(Error)
      exception = @@exceptions[e.class.to_s.underscore]
      if !exception
        raise Error.new(@objects[:object], "#{e.class}: #{e.message}")
      end
      raise exception.classify.constantize.new(@objects[:object], e.message)
    end

  end
end
