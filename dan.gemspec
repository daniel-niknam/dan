# frozen_string_literal: true

require_relative "lib/dan/version"

Gem::Specification.new do |spec|
  # since "dan" is already taken
  spec.name = "dan-engine"
  spec.version = Dan::VERSION
  spec.authors = ["Daniel Niknam"]
  spec.email = ["daniel-niknam@users.noreply.github.com"]

  spec.summary = "Ruby template engine"
  spec.description = "Dan is a ruby template engine that is optimised for writing better and simpler UI code. It provides an easy way to create components, view and reuse them."
  spec.homepage = "https://github.com/daniel-niknam/dan"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/master/CHANGELOG.md"

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
