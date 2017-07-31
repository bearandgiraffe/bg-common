require 'bg/common/version'
require 'bg/common/middlewares/basic_auth'

module BG
  module Common
    class << self
      def load!
        if rails?
          register_railtie
          register_engine
        end
      end

      def logger
        # TODO: Make this configurable
        @logger ||= Logging.logger['bg_common']
        @logger.level = :debug

        @logger.add_appenders \
          Logging.appenders.stdout,
          Logging.appenders.file('log/bg_common.log')
      end

      # Paths
      def gem_path
        @gem_path ||= File.expand_path '../..', File.dirname(__FILE__)
      end

      def active_job?
        defined?(::ActiveJob::Base)
      end

      def rails?
        defined?(::Rails)
      end

      private

      def register_railtie
        require 'bg/common/rails'
      end

      def register_engine
        require 'bg/common/engine'
      end
    end
  end
end

BG::Common.load!
