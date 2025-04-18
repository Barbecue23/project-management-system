# -*- encoding: utf-8 -*-
# stub: overcommit 0.67.1 ruby lib

Gem::Specification.new do |s|
  s.name = "overcommit".freeze
  s.version = "0.67.1".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "changelog_uri" => "https://github.com/sds/overcommit/blob/main/CHANGELOG.md" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Shane da Silva".freeze]
  s.date = "2025-03-03"
  s.description = "Utility to install, configure, and extend Git hooks".freeze
  s.email = ["shane@dasilva.io".freeze]
  s.executables = ["overcommit".freeze]
  s.files = ["bin/overcommit".freeze]
  s.homepage = "https://github.com/sds/overcommit".freeze
  s.licenses = ["MIT".freeze]
  s.post_install_message = "Install hooks by running `overcommit --install` in your Git repository".freeze
  s.required_ruby_version = Gem::Requirement.new(">= 2.6".freeze)
  s.rubygems_version = "3.6.2".freeze
  s.summary = "Git hook manager".freeze

  s.installed_by_version = "3.5.23".freeze

  s.specification_version = 4

  s.add_runtime_dependency(%q<childprocess>.freeze, [">= 0.6.3".freeze, "< 6".freeze])
  s.add_runtime_dependency(%q<iniparse>.freeze, ["~> 1.4".freeze])
  s.add_runtime_dependency(%q<rexml>.freeze, [">= 3.3.9".freeze])
end
