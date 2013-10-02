require 'spec_helper'

describe Rjax, :type => :request do
  let(:app)  { Rails.application }
  let(:body) { last_response.body.strip }

  it 'rjax template' do
    ajax '/users'

    body.should == 'Sam, Alise, John'
  end

  it 'rjax general partial' do
    ajax '/users/search'

    body.should == 'Sam, John'
  end

  it 'rjax collection partial' do
    ajax '/users/popular'

    body.should == "Jessy\nWalt"
  end

  it 'rjax instance template' do
    ajax '/users/1'

    body.should == 'Alex'
  end

  it 'convention general partial' do
    ajax '/articles'

    body.should == "Monday\nTuesday\nSunday"
  end

  it 'convention collection partial' do
    ajax '/articles/search'

    body.should == "Monday, Sunday"
  end

  it 'collection instance partial' do
    ajax '/articles/1'

    body.should == "Monday"
  end

  it 'raise error is configurated incorrect' do
    expect do
      described_class.config do |config|
        config.suffix = ""
        config.prefix = ""
      end
    end.to raise_error(Rjax::InvalidConfigurationError)
  end

  def ajax(path)
    get path, {}, { "HTTP_X_REQUESTED_WITH" => "XMLHttpRequest", 'HTTP_ACCEPT' => '*/*' }
  end
end
