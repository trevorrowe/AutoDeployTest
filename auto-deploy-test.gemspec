lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'auto_deploy_test/version'

Gem::Specification.new do |spec|
  spec.name          = 'auto-deploy-test'
  spec.version       = AutoDeployTest::VERSION
  spec.summary       = 'A project for testing build and release features of Travis-CI and GitHub.'
  spec.description   = <<-DESC.strip
A simple project to test auto building and release using GitHub and Travis-CI.
The goal is to fully automate test, build, and release as the result of a
tag push. The release needs to have release artifacts including the gem,
docs, and release notes.
  DESC
  spec.author        = 'Trevor Rowe'
  spec.email         = 'trevorrowe@gmail.com'
  spec.homepage      = 'http://github.com/trevorrowe/AutoDeployTest'
  spec.license       = 'Apache 2.0'
  spec.require_paths = ['lib']
  spec.files         = `git ls-files`.split("\n")
end
