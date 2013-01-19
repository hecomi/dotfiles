# -*- ruby -*-

require 'pathname'

base_dir = Pathname(__FILE__).dirname.expand_path
test_unit_dir = (base_dir.parent + "test-unit").expand_path
test_unit_lib_dir = test_unit_dir + "lib"
lib_dir = base_dir + "lib"

$LOAD_PATH.unshift(test_unit_lib_dir.to_s)
$LOAD_PATH.unshift(lib_dir.to_s)

require 'test/unit/notify'

require 'rubygems'
require 'hoe'

Test::Unit.run = true

version = Test::Unit::Notify::VERSION
ENV["VERSION"] = version
Hoe.spec('test-unit-notify') do
  self.version = version
  self.rubyforge_name = "test-unit"

  developer('Kouhei Sutou', 'kou@clear-code.com')

  extra_deps << ["test-unit", ">= 2.1.2"]
end

task :docs do
  doc_dir = base_dir + "doc"
  doc_screenshot_dir = doc_dir + "screenshot"
  mkdir_p(doc_screenshot_dir.to_s)
  (base_dir + "screenshot").children.each do |file|
    next if file.directory?
    cp(file.to_s, doc_screenshot_dir.to_s)
  end
end

task :tag do
  message = "Released Test::Unit::Notify #{version}!"
  base = "svn+ssh://#{ENV['USER']}@rubyforge.org/var/svn/test-unit/extensions/test-unit-notify/"
  sh 'svn', 'copy', '-m', message, "#{base}trunk", "#{base}tags/#{version}"
end

# vim: syntax=Ruby
