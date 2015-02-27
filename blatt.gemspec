Gem::Specification.new do |spec|
  spec.name                   = "blatt"
  spec.version                = "1.0.0"
  spec.date                   = "2015-02-27"
  spec.summary                = "Just a DIC"
  spec.description            = "Just a DIC"
  spec.authors                = ["Pedro Gimenez"]
  spec.email                  = ["me@pedro.bz"]
  spec.files                  = Dir["lib/**/*.rb"] + Dir["spec/**/*.rb"]
  spec.homepage               = "http://github.com/pedrogimenez/blatt"
  spec.extra_rdoc_files       = ["README.md"]
  spec.required_ruby_version  = ">= 2.1.0"

  spec.add_development_dependency "rspec", "~> 3.0"
end
