# Jackad

Active Directory connector gem

## Installation

Add this line to your application's Gemfile:

    gem 'jackad'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install jackad

## Usage

Configure your AD connection with


    module Jackad

      LDAP_CONFIG = { host: 'example.com',
                port: 389,
                base: 'dc=example,dc=com',
                attribute: 'sAMAccountName',
                admin_user: 'admin_username',
                admin_password: 'admin_password',
                method: 'simple',
                ssl: false,
                admin: false
                }

    end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
