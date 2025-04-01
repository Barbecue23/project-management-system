# -*- encoding: utf-8 -*-
# stub: omniauth-azure-oauth2 0.0.10 ruby lib

Gem::Specification.new do |s|
  s.name = "omniauth-azure-oauth2".freeze
  s.version = "0.0.10".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Mark Nadig".freeze]
  s.date = "2018-11-07"
  s.description = "An Windows Azure Active Directory OAuth2 strategy for OmniAuth".freeze
  s.email = ["mark@nadigs.net".freeze]
  s.homepage = "https://github.com/KonaTeam/omniauth-azure-oauth2".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.4.8".freeze
  s.summary = "An Windows Azure Active Directory OAuth2 strategy for OmniAuth".freeze

  s.installed_by_version = "3.5.23".freeze

  s.specification_version = 4

  s.add_runtime_dependency(%q<omniauth>.freeze, ["~> 1.0".freeze])
  s.add_runtime_dependency(%q<jwt>.freeze, [">= 1.0".freeze, "< 3.0".freeze])
  s.add_runtime_dependency(%q<omniauth-oauth2>.freeze, ["~> 1.4".freeze])
  s.add_development_dependency(%q<rspec>.freeze, [">= 2.14.0".freeze])
  s.add_development_dependency(%q<rake>.freeze, [">= 0".freeze])
end
