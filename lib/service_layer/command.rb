module ServiceLayer
  class Command
    cattr_writer :exceptions
    @@exceptions = {
      #"active_record/record_not_saved" => PersistError,
      #"active_record/record_invalid" => PersistError
    }

    def initialize(service, objects, &block)
      @service = service
      @block = block
      @objects = objects
    end

    def method_missing(method, *args, &block)
      @service.send method, *args, &block
    end

    def execute
      @block.call
      @objects[:object]
    rescue StandardError => e
      exception = @@exceptions[e.class.to_s.underscore]
      unless exception
        raise Error.new(@objects[:object], "#{e.class}: #{e.message}")
      end
      raise exception.classify.constantize.new(@objects[:object], e.message)
    end

  end
end
