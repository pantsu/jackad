module Jackad
  class Config
    def self.setup
      YAML.load_file('/usr/local/jackad/ldap.yml')
    end
  end
end
