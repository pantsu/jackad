# Jackad

Active Directory connector gem

## Installation

Add this line to your application's Gemfile:

    gem 'jackad'

And then execute:

    $ bundle install

Or install it alone with:

    $ gem install jackad

Configure your AD connection with YAML file `/usr/local/jackad/ldap.yml`

    :host: 'example.com'
    :port: 389
    :base: 'dc=example,dc=com'
    :attribute: 'sAMAccountName'
    :method: 'simple'
    :ssl: false
    :admin: false
    :admin_user: 'admin_username'           # Only if admin:true needed
    :admin_password: 'admin_password'       # Only if admin:true needed

## Usage

Jackad gives you simple API to access your LDAP directory. All self methods return true or false

    Jackad.credentials_valid?('username@example.com', 'user_ldap_password')     # Check validity of username and password

    Jackad.entry_exists?('username')                                            # Check user existance by configured attribute

    Jackad.entry_valid?(username)                                               # Check user validity by configured attribute, useraccountcontrol flags and pwdlastset attribute

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
