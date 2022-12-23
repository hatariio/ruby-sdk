
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "hatari_ruby_sdk/version"

Gem::Specification.new do |spec|
  spec.name          = "hatari_ruby_sdk"
  spec.version       = HatariRubySdk::VERSION
  spec.authors       = ["Vicky Djoulako", "Ebot Tabi"]
  spec.email         = ["vicky@voyancehq.com", "e@voyancehq.com"]

  spec.summary       = %q{Use this gem from any Ruby application where you want to integrate with Hatari.}
  spec.description   = %q{This gem should use in any Ruby application to push events to Hatari platform}
  spec.homepage      = "https://github.com/hatariio/ruby-sdk"
  spec.license       = "MIT"
  #spec.required_ruby_version = '=> 2.6.1'
  spec.platform      = Gem::Platform::RUBY

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  #spec.bindir        = "exe"
  #spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.12.0"
end
