require "net/ldap"

module Jackad
  module Net
    class LDAP < ::Net::LDAP

      def search(args = {})
        super(args) || []
      rescue => e
        case e.message
        when /refused connection/
          raise Jackad::ConnectionRefused, e.message
        else
          raise
        end
      end

    end
  end
end
