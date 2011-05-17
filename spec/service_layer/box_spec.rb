require 'spec_helper'

describe ServiceLayer::Box do
  before do
    @service = UserService.new
    @object = 'Test'
  end

  describe '#execute' do
    it 'should be convert StandardException to Error' do
      lambda {@service.work_with_raise_exception(@object, StandardError)}.should raise_error(ServiceLayer::Error)
    end

    it 'should not be convert descendant of Error' do
      lambda {@service.work_with_raise_exception(@object, DescendantError)}.should raise_error(DescendantError)
    end
  end
end
