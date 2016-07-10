# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'itamae/plugin/recipe/gitlab/version'

Gem::Specification.new do |spec|
  spec.name          = "itamae-plugin-recipe-gitlab"
  spec.version       = Itamae::Plugin::Recipe::Gitlab::VERSION
  spec.authors       = ["Slowhand0309"]
  spec.email         = ["slowhand0309@gmail.com"]

  spec.summary       = %q{Itamae plugin for gitlab.}
  spec.description   = %q{Itamae plugin for gitlab.}
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Runtime Dependencies
  spec.add_runtime_dependency "itamae", "~> 1.9"

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "serverspec", "~> 2.3"
end
