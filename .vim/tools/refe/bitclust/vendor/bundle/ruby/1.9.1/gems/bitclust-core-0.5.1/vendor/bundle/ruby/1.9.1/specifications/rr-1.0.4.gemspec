# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "rr"
  s.version = "1.0.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Brian Takita"]
  s.date = "2011-06-16"
  s.description = "RR (Double Ruby) is a double framework that features a rich selection of double techniques and a terse syntax. http://xunitpatterns.com/Test%20Double.html"
  s.email = "brian@pivotallabs.com"
  s.extra_rdoc_files = ["CHANGES", "README.rdoc"]
  s.files = ["CHANGES", "README.rdoc"]
  s.homepage = "http://pivotallabs.com"
  s.rdoc_options = ["--main", "README.rdoc", "--inline-source", "--line-numbers"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "pivotalrb"
  s.rubygems_version = "1.8.24"
  s.summary = "RR (Double Ruby) is a double framework that features a rich selection of double techniques and a terse syntax. http://xunitpatterns.com/Test%20Double.html"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
