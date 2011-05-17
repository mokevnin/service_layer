class DescendantError < ServiceLayer::Error ; end

class UserService < ServiceLayer::Service
  def create(object)
    handle object do
      do_work
    end
  end

  def work_with_raise_exception(object, exception)
    handle object do
      raise exception
    end
  end

  private

  def do_work

  end
end
