module ServiceLayer
  class Service
    def handle(object, &block)
      command = Command.new self, object, &block
      command.execute
    end
  end
end
