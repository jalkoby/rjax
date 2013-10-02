require 'active_support'

module Rjax
  autoload :Config,                    'rjax/config'
  autoload :InvalidConfigurationError, 'rjax/errors'
  autoload :Resolver,                  'rjax/resolver'
  autoload :PartialMissingError,      'rjax/errors'

  def self.config(&block)
    @config ||= ::Rjax::Config.new
    if block_given?
      yield(@config)
      @config.validate!
    else
      @config
    end
  end
end

ActiveSupport.on_load(:action_controller) do
  class_eval do
    private

    def rjax(options = nil)
      render(Rjax::Resolver.process(options, self)) if request.xhr?
    end
  end
end
