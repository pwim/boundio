# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "boundio/version"

Gem::Specification.new do |s|
  s.name        = "boundio"
  s.version     = Boundio::VERSION
  s.authors     = ["Paul McMahon"]
  s.email       = ["paul@mobalean.com"]
  s.homepage    = "http://boundio.jp"
  s.summary     = %q{Wrapper for Boundio API}
  s.description = %q{Boundio is KDDI's telephony API. This is a simple wrapper for it.}

  s.rubyforge_project = "boundio"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "minitest"
  s.add_development_dependency "webmock"
  s.add_runtime_dependency "activesupport"
  s.add_runtime_dependency "rest-client"
  s.add_runtime_dependency "thor"
end
