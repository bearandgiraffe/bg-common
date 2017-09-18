module BG
  module Common
    module Analytics
      module Intercom
        class Client
          def initialize
            @intercom = ::Intercom::Client.new token: ENV['INTERCOM_ACCESS_TOKEN']
          end

          def intercom
            @intercom ||= ::Intercom::Client.new token: ENV['INTERCOM_ACCESS_TOKEN']
          end

          def call data
            make_intercom_call do |client|
              client.events.create data
            end
          end

          def make_intercom_call &block
            begin
              yield self.intercom
            rescue ::Intercom::IntercomError => e
              # TODO: report this to newrelic so we won't lose any important
              # errors that we might have to fix.
              BG::Common.logger.debug "Intercom call failed: #{e.inspect}"
            end
          end

          private

          def config
            ::IntercomRails.config
          end
        end
      end
    end
  end
end
