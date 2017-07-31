module BG
  module Common
    module Analytics
      class IntercomSyncUsersJob < ::ActiveJob::Base
        queue_as :analytics

        def perform
          users = User.all

          users.each do |user|
            Analytics::Intercom.update_user user
          end unless users.blank?
        end
      end
    end
  end
end