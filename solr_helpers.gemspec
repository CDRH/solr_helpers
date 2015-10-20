$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "solr_helpers/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "solr_helpers"
  s.version     = SolrHelpers::VERSION
  s.authors     = ["Jessica Dussault"]
  s.email       = ["jdussault4@gmail.com"]
  # s.homepage    = "TODO"
  s.summary     = "View helpers for CDRH Rails API sites"
  s.description = "Includes pagination bar and several useful tools for faceting"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.1.10"

  s.add_development_dependency "sqlite3"
end
