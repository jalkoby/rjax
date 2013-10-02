module Rjax
  class BaseError < ::StandardError
  end

  class InvalidConfigurationError < BaseError
  end

  class PartialMissingError < BaseError
  end
end

