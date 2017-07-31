module BG
  module Common
    module Analytics
      class IntercomCreateUserJob < ::ActiveJob::Base
        queue_as :analytics

        def perform data
          Intercom::Client.new.make_intercom_call do |client|
            client.users.create data
          end
        end
      end
    end
  end
end
