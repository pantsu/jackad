require "jackad/version"
require "net-ldap"

module Jackad


  # Check validity of username and password
  def self.valid_credentials?(username, password)
    ad = AdConnect.new()
    ad.ldap.auth(username, password)
    ad.ldap.bind
  end

  # Check user existance
  def self.user_exists?

  end

  class AdConnect

    attr_reader :ldap

    def initialize(params = {})
      ldap_config = { host: 'yamoney.ru',
                      port: 389,
                      base: 'dc=yamoney,dc=ru',
                      attribute: 'sAMAccountName',
                      admin_user: 'usrLdapConnect@yamoney.ru',
                      admin_password: 'shie3Ahy',
                      method: 'simple',
                      ssl: false
                    }

      ldap_options = params

      @ldap = Net::LDAP.new(ldap_options)
      @ldap.host = ldap_config[:host]
      @ldap.port = ldap_config[:port]
      @ldap.base = ldap_config[:base]
      @attribute = ldap_config[:attribute]

      @ldap.auth ldap_config[:admin_user], ldap_config[:admin_password] if params[:admin]

      @login = params[:login]
      @password = params[:password]
      @new_password = params[:new_password]
    end

    def search_for_user
      filter = Net::LDAP::Filter.eq(@attribute.to_s, @login.to_s)
      ldap_entry = nil
      @ldap.search(:filter => filter) { |entry| ldap_entry = entry }
      ldap_entry
    end

  end

end
