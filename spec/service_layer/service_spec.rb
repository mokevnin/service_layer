require 'spec_helper'

describe ServiceLayer::Service do
  before do
    @service = UserService.new
    @object = 'Test'
  end

  describe '#handle' do
    it 'should be return object' do
      @service.create(@object).should == @object
    end
  end
end
