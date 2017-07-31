module BG
  module Common
    module Analytics
      class IntercomExportUsersJob < ::ActiveJob::Base
        queue_as :analytics

        def perform data
          Intercom::Client.new.make_intercom_call do |client|
            client.users.submit_bulk_job(create_items: data)
          end
        end
      end
    end
  end
end
