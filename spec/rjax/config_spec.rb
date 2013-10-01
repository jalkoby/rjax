require 'spec_helper'

describe Rjax::Config do
  let(:config) { described_class.new }

  context '#template_name' do
    subject { config.template_name('index') }

    specify { should == 'index_rjax' }

    it 'with custom suffix' do
      config.suffix = "ajax"
      should == "index_ajax"
    end

    it 'with prefix' do
      config.prefix = "super"
      should == "super_index_rjax"
    end

    it 'with prefix and without suffix' do
      config.suffix = false
      config.prefix = "ajax"
      should == "ajax_index"
    end

    it 'without prefix and suffix' do
      config.suffix = false
      expect { subject }.to raise_error(Rjax::InvalidConfigurationError)
    end
  end
end
