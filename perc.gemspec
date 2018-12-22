# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'perc/version'

Gem::Specification.new do |spec|
  spec.name          = "perc"
  spec.version       = Perc::VERSION
  spec.authors       = ["Jason Wall"]
  spec.email         = ["jasonw@getyardstick.com"]

  spec.summary       = %q{Lightweight application framework for building things that are not necessarily #railsthings}
  spec.description   = %q{}
  spec.homepage      = "https://github.com/yardstick/perc"
  spec.license       = "MIT"

  spec.executables << ["perc"]

  spec.files         = [
                         ".gitignore",
                         ".rspec",
                         ".travis.yml",
                         "CODE_OF_CONDUCT.md",
                         "Gemfile",
                         "LICENSE.txt",
                         "README.md",
                         "Rakefile",
                         "bin/console",
                         "exe/perc",
                         "lib/perc.rb",
                         "lib/perc/application.rb",
                         "lib/perc/cli.rb",
                         "lib/perc/cli_wrapper.rb",
                         "lib/perc/version.rb",
                         "perc.gemspec",
                         "template_app/app/.gitkeep",
                         "template_app/config/application.rb",
                         "template_app/config/environment.rb",
                         "template_app/config/environments/development.rb",
                         "template_app/config/environments/production.rb",
                         "template_app/config/environments/test.rb",
                         "template_app/config/initializers/.gitkeep"
                       ]
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "activesupport", ">= 4.0", "< 5.1"
  spec.add_runtime_dependency "thor", "~> 0.19"
  spec.add_runtime_dependency "rake", "~> 10.0"

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rspec", "~> 3.0"
end
