# -*- encoding: utf-8 -*-
# stub: aasm 4.3.0 ruby lib

Gem::Specification.new do |s|
  s.name = "aasm"
  s.version = "4.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Scott Barron", "Travis Tilley", "Thorsten Boettger"]
  s.date = "2015-09-10"
  s.description = "AASM is a continuation of the acts-as-state-machine rails plugin, built for plain Ruby objects."
  s.email = "scott@elitists.net, ttilley@gmail.com, aasm@mt7.de"
  s.homepage = "https://github.com/aasm/aasm"
  s.licenses = ["MIT"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.3")
  s.rubygems_version = "2.4.8"
  s.summary = "State machine mixin for Ruby objects"

  s.installed_by_version = "2.4.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<sdoc>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 3"])
      s.add_development_dependency(%q<pry>, [">= 0"])
    else
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<sdoc>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 3"])
      s.add_dependency(%q<pry>, [">= 0"])
    end
  else
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<sdoc>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 3"])
    s.add_dependency(%q<pry>, [">= 0"])
  end
end
