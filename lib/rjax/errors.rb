module Rjax
  class BaseError < ::StandardError
  end

  class InvalidConfigurationError < BaseError
  end

  class TemplateMissingError < BaseError
  end
end

