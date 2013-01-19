# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "test-unit-notify"
  s.version = "0.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Kouhei Sutou"]
  s.date = "2011-04-15"
  s.description = "Test::Unit::Notify - A test result notify extension for Test::Unit."
  s.email = ["kou@clear-code.com"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.txt"]
  s.files = ["History.txt", "Manifest.txt", "README.txt"]
  s.homepage = "http://rubyforge.org/projects/test-unit/"
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "test-unit"
  s.rubygems_version = "1.8.24"
  s.summary = "Test::Unit::Notify - A test result notify extension for Test::Unit."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<test-unit>, [">= 2.1.2"])
      s.add_development_dependency(%q<hoe>, [">= 2.8.0"])
    else
      s.add_dependency(%q<test-unit>, [">= 2.1.2"])
      s.add_dependency(%q<hoe>, [">= 2.8.0"])
    end
  else
    s.add_dependency(%q<test-unit>, [">= 2.1.2"])
    s.add_dependency(%q<hoe>, [">= 2.8.0"])
  end
end
