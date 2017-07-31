#
# Module that wraps the Intercom users API.
#
module BG
  module Common
    module Analytics
      module Intercom
        module User
          #
          # Exports users to Intercom.
          #
          # @param limit, Integer, Sets the limit of users to export.
          #
          def export_users limit=nil
            users = ::User.all

            if limit
              users = users.limit(limit)
            end

            data = users.map { |user| intercom_user_object user }

            IntercomExportUsersJob.perform_later data
          end

          #
          # Creates user in Intercom.
          #
          # @param user,    User
          #
          def create_user user
            data = intercom_user_object user

            IntercomCreateUserJob.perform_later data
          end

          #
          # Updates user in Intercom.
          #
          # @param user,    User
          #
          def update_user user
            create_user user
          end

          private

          def intercom_user_object user
            {
              user_id:           user.id,
              email:             user.username,
              name:              user.name,
              signed_up_at:      user.created_at.to_i,
              custom_attributes: custom_attributes(user)
            }
          end

          def custom_attributes user
            # Override this method in your app to provide custom attributes
            # specific to your app to be passed on to Intercom.
            { }
          end
        end
      end
    end
  end
end
