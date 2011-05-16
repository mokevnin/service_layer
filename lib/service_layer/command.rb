module ServiceLayer
  class Command
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
        raise Error.new("#{e.class}: #{e.message}", @objects[:object])
      end
      raise exception.classify.constantize.new(e.message, @objects[:object])
    end

  end
end
