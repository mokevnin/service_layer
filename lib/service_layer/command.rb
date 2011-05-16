module ServiceLayer
  class Command
    @@exceptions = {
      :persist_error => ["active_record/record_not_saved", "active_record/record_invalid"]
    }

    def initialize(service, object, &block)
      @service = service
      @block = block
      @object = object
    end

    def method_missing(method, *args, &block)
      @service.send method, *args, &block
    end

    def execute
      instance_eval &@block
      @object
    rescue StandardError => e
      unless @@exceptions[:persist_error].include? e.class.to_s.underscore
        raise Error.new("#{e.class}: #{e.message}")
      end
      raise PersistError.new(e.message, @object)
    end

  end
end
