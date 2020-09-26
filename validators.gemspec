# frozen_string_literal: true

require_relative "lib/validators/version"

Gem::Specification.new do |s|
  s.name        = "validators"
  s.version     = Validators::Version::STRING
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Nando Vieira"]
  s.email       = ["fnando.vieira@gmail.com"]
  s.homepage    = "http://rubygems.org/gems/validators"
  s.summary     = "Add some nice ActiveModel/ActiveRecord validators."
  s.description = s.summary
  s.license     = "MIT"
  s.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`
                    .split("\n")
                    .map {|f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "activerecord"
  s.add_development_dependency "aitch"
  s.add_development_dependency "cpf_cnpj"
  s.add_development_dependency "email_data"
  s.add_development_dependency "minitest-utils"
  s.add_development_dependency "mocha"
  s.add_development_dependency "nokogiri"
  s.add_development_dependency "pry-meta"
  s.add_development_dependency "rake"
  s.add_development_dependency "root_domain"
  s.add_development_dependency "rubocop"
  s.add_development_dependency "rubocop-fnando"
  s.add_development_dependency "simplecov"
  s.add_development_dependency "simplecov-console"
  s.add_development_dependency "simpleidn"
  s.add_development_dependency "sqlite3", "~> 1.4"
  s.add_development_dependency "sshkey"
  s.add_development_dependency "whois"
  s.add_development_dependency "whois-parser"
end
