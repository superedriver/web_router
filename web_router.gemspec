# coding: utf-8
lib = File.expand_path('../web_router', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require_relative 'lib/web_router/version'

Gem::Specification.new do |spec|
  spec.name          = "web_router"
  spec.version       = WebRouter::VERSION
  spec.authors       = ["superedriver"]
  spec.email         = ["superedriver@gmail.com"]

  spec.summary       = %q{Small router}
  spec.description   = %q{Small router based on RACK}
  spec.homepage      = "https://github.com/superedriver/web_router"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["web_router"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry"

  spec.add_dependency "rack", "~> 2.0"
  spec.add_dependency "oj", "~> 2.17"
end
