module Skylight
  module Normalize
    @registry = {}

    def self.normalize(trace, name, payload)
      klass = @registry[name]

      if klass
        klass.new(trace, name, payload).normalize
      else
        [ name, payload ]
      end
    end

    def self.register(name, klass)
      @registry[name] = klass
    end
  end

  class Normalizer
    def self.register(name)
      Normalize.register(name, self)
    end

    def initialize(trace, name, payload)
      @trace, @name, @payload = trace, name, payload
    end
  end
end

require "skylight/normalize/process_action"