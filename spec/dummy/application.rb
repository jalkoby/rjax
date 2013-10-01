require 'action_controller/railtie'
require 'action_view/railtie'

class Dummy < Rails::Application
  # Set Rails.root to the same folder as this file
  config.root = File.dirname(__FILE__)

  # Rails needs these keys, but they don't really have to be secret for our tests
  config.session_store :cookie_store, key: '****************************************'
  config.secret_token = '****************************************'

  # Log to spec/dummy/test.log
  config.logger = Logger.new(STDOUT)
  # This is important, otherwise the tests will fail
  Rails.logger = config.logger

  config.action_controller.view_path

  # Our routes
  routes.draw do
    controller :rjax do
      get '/' => :index
      get :about
    end
  end
end

class RjaxController < ActionController::Base
  prepend_view_path Rails.root
  layout 'rjax'

  def index
  end

  def about
  end
end
