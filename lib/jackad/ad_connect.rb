module Jackad
  class AdConnect

    attr_reader :ldap, :attribute

    def initialize(params = {})

      @ldap = Net::LDAP.new(params)
      @ldap.host = LDAP_CONFIG[:host]
      @ldap.port = LDAP_CONFIG[:port]
      @ldap.base = LDAP_CONFIG[:base]
      @attribute = params[:attribute] || LDAP_CONFIG[:attribute]
      @login = params[:login] || LDAP_CONFIG[:admin_user]
      @password = params[:password] || LDAP_CONFIG[:admin_password]

      @ldap.auth @login, @password

      @new_password = params[:new_password]
    end

    # Gets entry attributes from LDAP
    def get_entry_data(username, attrs = [] )
      filter = Net::LDAP::Filter.eq(@attribute.to_s, username)
      search_params = { filter: filter, size: 1 }
      search_params[:attributes] = attrs unless attrs.empty?
      @ldap.search(search_params)[0]
    end

    # Gets user guid from LDAP.
    # Returns binary Net::BER::BerIdentifiedString
    def get_entry_guid(username)
      filter = Net::LDAP::Filter.eq(@attribute.to_s, username)
      result = @ldap.search(filter: filter, attributes: ['objectguid'], size: 1)
      result.size > 0 ? result[0]['objectguid'][0] : nil
    end

    # Gets user guid from LDAP.
    # Returns string.
    def get_entry_guid_as_string(username)
      username = get_entry_guid(username)
      username.unpack('H*')[0].upcase unless username.nil?
    end

  end
end
