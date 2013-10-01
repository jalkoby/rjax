require 'spec_helper'

describe RjaxController, :type => :controller do
  let(:app) { Rails.application }
  let(:headers) { { "HTTP_X_REQUESTED_WITH" => "XMLHttpRequest" } }

  before do
    Rjax.instance_variable_set("@config", nil)
  end

  it 'render ajax template if it exists' do
    get '/', {}, headers

    last_response.should be_successful
    last_response.body.strip.should == "rjax#index_rjax"
  end

  context 'rjax template missing' do
    it 'raise error if configurated' do
      Rjax.config.raise_error = true
      get '/about', {}, headers

      last_response.status.should == 500
    end

    it 'render default template' do
      get '/about', {}, headers

      last_response.should be_successful
      last_response.body.strip.should == "layout - rjax#about"
    end
  end
end
