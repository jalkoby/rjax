require 'active_support/core_ext/string'

class Rjax::Resolver < Struct.new(:options, :controller)
  def self.process(*args)
    new(*args).process
  end

  def process
    case options
    when Hash     then general_partial
    when Array    then collection_partial
    when NilClass then template_name
    else
      instance_partial
    end
  end

  private

  def general_partial
    partial = options.has_key?(:partial) ? options.delete(:partial) : partial_name(:multi)
    { :partial => partial, :locals => options, :layout => false }
  end

  def collection_partial
    { :partial => partial_name, :collection => options, :as => singular_name, :layout => false }
  end

  def instance_partial
    { :partial => partial_name, :locals => { singular_name.to_sym => options }, :layout => false }
  end

  def template_name
    rjax_version(controller.action_name).to_sym
  end

  def partial_name(multi = false)
    name = multi ? singular_name.pluralize : singular_name
    result = [rjax_version(name), name].detect { |item| controller.template_exists?(item, prefixes, true) }
    result ? result : raise(Rjax::PartialMissingError, name)
  end

  def singular_name
    @singular_name ||= controller.controller_name.singularize
  end

  def rjax_version(base)
    result = ""
    result << "#{ Rjax.config.prefix }_" if Rjax.config.prefix?
    result << base
    result << "_#{ Rjax.config.suffix }" if Rjax.config.suffix?
    result
  end

  def prefixes
    @prefixes ||= controller.send(:_normalize_render)[:prefixes]
  end
end
