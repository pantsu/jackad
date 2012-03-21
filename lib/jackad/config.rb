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