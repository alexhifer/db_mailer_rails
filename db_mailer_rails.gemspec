
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'db_mailer_rails/version'

Gem::Specification.new do |s|
  s.name                  = 'db_mailer_rails'
  s.version               = DbMailerRails::VERSION.dup
s.authors                 = 'Alexey Degtyarev'
  s.email                 = 'alexhifer@gmail.com'

  s.required_ruby_version = '>= 2.1.0'
  s.summary               = %q{Store mail templates in the database.}
  s.description           = %q{This gem allows you to store mail templates in the database.}
  s.license               = 'MIT'

  s.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  s.bindir                = 'exe'
  s.executables           = s.files.grep(%r{^exe/}) { |f| File.basename(f) }
  s.require_paths         = ['lib']

  s.add_dependency 'actionpack', '>= 6.0.2.2'
  s.add_dependency 'actionmailer', '>= 6.0.2.2'
  s.add_dependency 'railties', '>= 6.0.2.2'
  s.add_dependency 'mustache', '~> 1.1'
  s.add_development_dependency 'rspec', '~> 3.9.0'
  s.add_development_dependency 'sqlite3', '~> 1.4.2'
end
