# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "bitclust-core"
  s.version = "0.5.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["http://bugs.ruby-lang.org/projects/rurema"]
  s.date = "2012-08-14"
  s.description = "Rurema is a Japanese ruby documentation project, and\nbitclust is a rurema document processor.\n"
  s.email = [""]
  s.executables = ["bitclust"]
  s.files = ["bin/bitclust"]
  s.homepage = "http://doc.ruby-lang.org/ja/"
  s.require_paths = ["lib"]
  s.rubyforge_project = ""
  s.rubygems_version = "1.8.24"
  s.summary = "BitClust is a rurema document processor."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<test-unit>, [">= 2.3.0"])
      s.add_runtime_dependency(%q<rack>, [">= 0"])
    else
      s.add_dependency(%q<test-unit>, [">= 2.3.0"])
      s.add_dependency(%q<rack>, [">= 0"])
    end
  else
    s.add_dependency(%q<test-unit>, [">= 2.3.0"])
    s.add_dependency(%q<rack>, [">= 0"])
  end
end
