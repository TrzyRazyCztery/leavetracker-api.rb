module Exceptions
  class ValidationFailed < StandardError
    attr_accessor :errors

    def initialize(errors = {})
      self.errors = errors
    end
  end
end