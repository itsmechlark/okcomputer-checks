# frozen_string_literal: true

require_relative "lib/ok_computer/checks/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "okcomputer-checks"
  s.version     = OkComputer::Checks.gem_version

  s.authors = ["John Chlark Sumatra"]
  s.email   = ["clark@sumatra.com.ph"]

  s.license     = "MIT"
  s.homepage    = "https://github.com/itsmechlark/okcomputer-checks"
  s.summary     = "Collection health-check for okcomputer"
  s.description = %(
    Collection health-check for okcomputer
  )

  s.metadata = {
    "homepage_uri" => s.homepage,
    "changelog_uri" => "https://github.com/itsmechlark/okcomputer-checks/releases/tag/v#{s.version}",
    "source_code_uri" => "https://github.com/itsmechlark/okcomputer-checks/tree/v#{s.version}",
    "bug_tracker_uri" => "https://github.com/itsmechlark/okcomputer-checks/issues",
    "github_repo" => "https://github.com/itsmechlark/okcomputer-checks",
  }

  s.files = Dir["lib/**/*", "CHANGELOG.md", "LICENSE.md"]
  s.require_paths       = ["lib"]
  s.extra_rdoc_files    = ["LICENSE", "README.md"]

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
