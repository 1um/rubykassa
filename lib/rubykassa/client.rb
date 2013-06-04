require 'rubykassa/configuration'

module Rubykassa
  class ConfigurationError < StandardError; end

  class Client
    class << self
      attr_accessor :configuration

      def configure
        self.configuration = Rubykassa::Configuration.new
        yield self.configuration

        raise ConfigurationError, "Alailable modes are :test or :production" unless [:test, :production].include? self.configuration.mode
        raise ConfigurationError, "Alailable http methods are :get or :post" unless [:get, :post].include? self.configuration.http_method
      end
    end
  end
end