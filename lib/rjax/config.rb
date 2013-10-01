class Rjax::Config
  attr_accessor :prefix, :raise_error, :suffix
  alias_method :raise_error?, :raise_error

  def suffix
    return @suffix if defined?(@suffix)
    @suffix = 'rjax'
  end

  def template_name(base)
    raise Rjax::InvalidConfigurationError, "provide suffix or prefix" unless suffix? || prefix?
    result = ""
    result << "#{ prefix }_" if prefix?
    result << base
    result << "_#{ suffix }" if suffix?
    result
  end

  private

  def suffix?
    suffix && !suffix.empty?
  end

  def prefix?
    prefix && !prefix.empty?
  end
end
