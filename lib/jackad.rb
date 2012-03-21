# -*- ruby encoding: utf-8 -*-

require "net-ldap"
require "jackad/version"
require "jackad/config"
require "jackad/ad_connect"
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

end
