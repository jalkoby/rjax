class Rjax::Config
  attr_accessor :prefix, :suffix

  def suffix
    return @suffix if defined?(@suffix)
    @suffix = 'rjax'
  end

  def suffix?
    suffix && !suffix.empty?
  end

  def prefix?
    prefix && !prefix.empty?
  end

  def validate!
    raise Rjax::InvalidConfigurationError, "provide suffix or prefix" unless suffix? || prefix?
  end
end
