module Jackad
  class Config
    def self.setup
      @@options ||= YAML.load_file('/usr/local/jackad.yml')
    end
  end
end
