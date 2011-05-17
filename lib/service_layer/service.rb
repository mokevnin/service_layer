require "observer"

module ServiceLayer
  class Service
    include Observable

    private

    def handle(object_or_objects, &block)
      if object_or_objects.is_a?(Hash) || !object_or_objects[:object]
        objects = {:object => object_or_objects}
      end

      changed
      notify_observers(self.class, caller_method, objects)

      box = Box.new self, objects, &block
      box.execute
    end

    def caller_method(depth=1)
      parse_caller(caller(depth+1).first).last
    end

    def parse_caller(at)
      if /^(.+?):(\d+)(?::in `(.*)')?/ =~ at
        file   = Regexp.last_match[1]
        line   = Regexp.last_match[2].to_i
        method = Regexp.last_match[3]
        [file, line, method]
      end
    end
  end
end
