module ServiceLayer
  class Service

    private

    def handle(object_or_objects, &block)
      objects = {:object => object_or_objects} unless object_or_objects.is_a?(Hash)
      command = Command.new self, objects, &block
      command.execute
    end
  end
end
