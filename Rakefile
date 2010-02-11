#!/usr/bin/env rake
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "ronimopi"
    gemspec.summary = "A simple extensible IRC bot"
    gemspec.description = <<-EOS
Ronimopi (or Robot Ninja Monkey Pirate) is a simple IRC bot based on the Isaac
framework. It is designed to be extensible, and is useful for e.g. simple
bookkeeping and queries.
EOS
    gemspec.email = "ilkka.s.laukkanen@gmail.com"
    gemspec.homepage = "http://github.com/ilkka/ronimopi"
    gemspec.authors = ["Ilkka Laukkanen"]
    gemspec.add_development_dependency 'isaac'
    gemspec.add_development_dependency 'shoulda'
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or some dependency) not found. Install them before continuing."
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/test_*.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :test => :check_dependencies

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "test #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

