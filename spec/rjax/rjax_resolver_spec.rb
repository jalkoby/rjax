require 'spec_helper'

describe Rjax::Resolver do
  context '#rjax_version' do
    let(:controller) { double("Controller", :action_name => "index" ) }
    let(:config)     { Rjax.config }
    subject          { described_class.process(nil, controller) }

    specify { should == :index_rjax }

    it 'with custom suffix' do
      config.suffix = "ajax"
      should == :index_ajax
    end

    it 'with prefix' do
      config.prefix = "super"
      should == :super_index_rjax
    end

    it 'with prefix and without suffix' do
      config.suffix = false
      config.prefix = "ajax"
      should == :ajax_index
    end
  end
end
