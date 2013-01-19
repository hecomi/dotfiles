# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "bitclust-dev"
  s.version = "0.5.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["http://bugs.ruby-lang.org/projects/rurema"]
  s.bindir = "tools"
  s.date = "2012-08-14"
  s.description = "Rurema is a Japanese ruby documentation project, and\nbitclust is a rurema document processor.\nThis is tools for Rurema developpers.\n"
  s.email = [""]
  s.executables = ["bc-tochm.rb", "bc-methods.rb", "bc-checkparams.rb", "bc-ancestors.rb", "bc-list.rb", "stattodo.rb", "statrefm.rb", "bc-classes.rb", "bc-tohtml.rb", "forall-ruby.rb", "gencatalog.rb", "bc-convert.rb", "bc-rdoc.rb", "bc-preproc.rb", "update-database.rb", "bc-tohtmlpackage.rb", "check-signature.rb"]
  s.files = ["tools/bc-tochm.rb", "tools/bc-methods.rb", "tools/bc-checkparams.rb", "tools/bc-ancestors.rb", "tools/bc-list.rb", "tools/stattodo.rb", "tools/statrefm.rb", "tools/bc-classes.rb", "tools/bc-tohtml.rb", "tools/forall-ruby.rb", "tools/gencatalog.rb", "tools/bc-convert.rb", "tools/bc-rdoc.rb", "tools/bc-preproc.rb", "tools/update-database.rb", "tools/bc-tohtmlpackage.rb", "tools/check-signature.rb"]
  s.homepage = "http://doc.ruby-lang.org/ja/"
  s.require_paths = ["lib"]
  s.rubyforge_project = ""
  s.rubygems_version = "1.8.24"
  s.summary = "BitClust is a rurema document processor."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<bitclust-core>, ["= 0.5.1"])
      s.add_development_dependency(%q<test-unit>, [">= 2.3.0"])
    else
      s.add_dependency(%q<bitclust-core>, ["= 0.5.1"])
      s.add_dependency(%q<test-unit>, [">= 2.3.0"])
    end
  else
    s.add_dependency(%q<bitclust-core>, ["= 0.5.1"])
    s.add_dependency(%q<test-unit>, [">= 2.3.0"])
  end
end
