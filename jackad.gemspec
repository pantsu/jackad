# -*- encoding: utf-8 -*-
require File.expand_path('../lib/jackad/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Nick Kugaevsky"]
  gem.email         = ["nick@kugaevsky.ru"]
  gem.description   = %q{ Simple LDAP (Active Directory) connector }
  gem.summary       = gem.description
  gem.homepage      = "https://github.com/pantsu/jackad"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "jackad"
  gem.require_paths = ["lib"]
  gem.version       = Jackad::VERSION

  gem.add_dependency 'net-ldap', '~>0.2.0'
  # gem.add_dependency 'yaml'

  #gem.add_development_dependency('rspec')

end
