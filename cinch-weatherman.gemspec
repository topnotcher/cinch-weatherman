# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cinch/plugins/weatherman/version'

Gem::Specification.new do |gem|
  gem.name          = "cinch-weatherman"
  gem.version       = Cinch::Weatherman::VERSION
  gem.authors       = ["Brian Haberer"]
  gem.email         = ["bhaberer@gmail.com"]
  gem.description   = %q{Cinch Plugin to get Weather data using the Weather-Underground gem}
  gem.summary       = %q{Cinch Plugin to get Weather data}
  gem.homepage      = "https://github.com/canonical-hackers/cinch-weatherman"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'cinch', '>= 2.0.0'
  gem.add_dependency 'weather-underground', '>= 1.1.1'
  gem.add_dependency 'time-lord', '1.0.1'
  gem.add_dependency 'cinch-cooldown'
end
