# frozen_string_literal: true

$LOAD_PATH.push(File.expand_path("lib", __dir__))

# Maintain your gem's version:
require "ok_computer/checks/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "okcomputer-checks"
  s.version     = OkComputer::Checks::VERSION
  s.author      = "First Circle Engineering"
  s.email       = "tech@firstcircle.com"
  s.license     = "MIT"
  s.homepage    = "https://github.com/carabao-capital/okcomputer-checks"
  s.summary     = "Collection health-check for okcomputer"
  s.description = %(
    Collection health-check for okcomputer
  )

  s.files               = %x(git ls-files).split("\n") - [".gitignore", ".travis.yml", ".ruby-version"]
  s.require_paths       = ["lib"]
  s.extra_rdoc_files    = ["LICENSE", "README.md"]

  s.metadata = {
    "source_code_uri" => "https://github.com/carabao-capital/okcomputer-checks/tree/v#{s.version}",
    "allowed_push_host" => "https://rubygems.org",
  }

  s.required_ruby_version = ">= 2.7.0"

  s.add_dependency("activesupport")
  s.add_dependency("faraday")
  s.add_dependency("okcomputer")

  s.add_development_dependency("appraisal", "~> 2.4")
  s.add_development_dependency("codecov")
  s.add_development_dependency("code-scanning-rubocop")
  s.add_development_dependency("dotenv")
  s.add_development_dependency("em-http-request")
  s.add_development_dependency("nexmo")
  s.add_development_dependency("pusher")
  s.add_development_dependency("rake", "~> 13.0")
  s.add_development_dependency("rspec-rails")
  s.add_development_dependency("rubocop-performance")
  s.add_development_dependency("rubocop-rails")
  s.add_development_dependency("rubocop-rake")
  s.add_development_dependency("rubocop-rspec")
  s.add_development_dependency("rubocop-shopify", "~> 2.14")
  s.add_development_dependency("simplecov")
  s.add_development_dependency("simplecov-lcov")
  s.add_development_dependency("webmock")
end
