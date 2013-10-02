require 'action_controller/railtie'
require 'action_view/railtie'

class Dummy < Rails::Application
  # Set Rails.root to the same folder as this file
  config.root = File.dirname(__FILE__)

  # Rails needs these keys, but they don't really have to be secret for our tests
  config.session_store :cookie_store, key: '****************************************'
  config.secret_token = '****************************************'

  config.logger = Logger.new(STDOUT)
  Rails.logger = config.logger

  config.action_controller.view_path

  # Our routes
  routes.draw do
    resources :users, :only => [:index, :show] do
      get :search, :popular, :on => :collection
    end
    resources :articles, :only => [:index, :show] do
      get :search, :on => :collection
    end
  end
end

class BaseController < ActionController::Base
  prepend_view_path Rails.root
end

class UsersController < BaseController
  def index
    @users = %w(Sam Alise John)
    rjax
  end

  def search
    rjax :users => %w(Sam John)
  end

  def popular
    rjax %w(Jessy Walt)
  end

  def show
    rjax "Alex"
  end
end

class ArticlesController < BaseController
  def index
    rjax %w(Monday Tuesday Sunday)
  end

  def search
    rjax :articles => %w(Monday Sunday)
  end

  def show
    rjax "Monday"
  end
end
