module Bg
  module Common
    module Constraints
      class ApiConstraint
        def initialize version: 1, default: true
          @version = version
          @default = default
        end

        def matches? request
          versioned_accept_header?(request) || @default
        end

        private

        def versioned_accept_header? request
          accept = request.headers['Accept']

          if accept
            mime_type, version = accept.gsub(/\s/, "").split(";")
            return mime_type.match(/vnd\.jbh\+json/) && version == "version=#{@version}"
          end

          return false
        end
      end
    end
  end
end

