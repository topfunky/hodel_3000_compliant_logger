require 'rake'

begin
  require 'jeweler'

  Jeweler::Tasks.new do |gem|
    gem.name = "hodel_3000_compliant_logger"
    gem.version = "0.1.1"
    gem.summary = %Q{Alternate logger for Rails that emits syslog-style output. For use with pl_analyze gem.}
    gem.description = %Q{Alternate logger for Rails that emits syslog-style output. For use with pl_analyze gem.}
    gem.email = "boss@topfunky.com"
    gem.homepage = "http://github.com/topfunky/hodel_3000_compliant_logger"
    gem.authors = ["Geoffrey Grosenbach"]
    gem.add_development_dependency "rspec", "~> 1.3.0"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end

  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rspec/core/rake_task'

desc 'Default: run specs.'
task :default => :spec

desc "Run specs"
RSpec::Core::RakeTask.new
