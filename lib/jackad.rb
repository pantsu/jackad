# -*- ruby encoding: utf-8 -*-

require "jackad/version"
require "jackad/config"
require "net-ldap"

module Jackad


  # Check validity of username and password
  # Returns true or false
  def self.credentials_valid?(username, password)
    ad = AdConnect.new()
    ad.ldap.auth(username, password)
    ad.ldap.bind
  end

  # Check user existance by configured attribute
  # Returns true or false
  def self.entry_exists?(username)
    ad = AdConnect.new()
    filter = Net::LDAP::Filter.eq(ad.attribute.to_s , username)
    ad.ldap.search(filter: filter, size: 1).size > 0 ? true : false
  end

  # Check user validity by configured attribute, useraccountcontrol flags and pwdlastset attribute
  # Returns true or false
  def self.entry_valid?(username)
    ad = AdConnect.new()
    filter_by_attr = Net::LDAP::Filter.eq(ad.attribute.to_s, username)
    filter_by_uac = ~Net::LDAP::Filter.construct('useraccountcontrol:1.2.840.113556.1.4.803:=2')
    filter_by_pass = ~Net::LDAP::Filter.eq('pwdlastset', '0')
    filter = filter_by_attr & filter_by_uac & filter_by_pass
    ad.ldap.search(filter: filter, size: 1).size > 0 ? true : false
  end

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
      @ldap.search(filter: filter, attributes: ['objectguid'], size: 1)[0]['objectguid'][0]
    end

    # Gets user guid from LDAP.
    # Returns string.
    def get_entry_guid_as_string(username)
      get_entry_guid(username).unpack('H*')[0].upcase
    end

  end

end