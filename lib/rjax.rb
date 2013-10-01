require 'active_support'

module Rjax
  autoload :Config,                    'rjax/config'
  autoload :InvalidConfigurationError, 'rjax/errors'
  autoload :TemplateMissingError,      'rjax/errors'

  def self.config(&block)
    @config ||= ::Rjax::Config.new
    block_given? ? yield(@config) : @config
  end
end

ActiveSupport.on_load(:action_controller) do
  class_eval do
    private

    def default_render_with_rjax(*args, &block)
      if request.xhr?
        defaults = _normalize_render
        prefixes = defaults[:prefixes]
        rjax_action = Rjax.config.template_name(defaults[:template])
        if template_exists?(rjax_action, prefixes)
          return render(rjax_action, :layout => false, :prefixes => prefixes)
        elsif Rjax.config.raise_error?
          raise Rjax::TemplateMissingError, rjax_action
        end
      end
      default_render_without_rjax(*args, &block)
    end
    alias_method_chain :default_render, :rjax
  end
end
