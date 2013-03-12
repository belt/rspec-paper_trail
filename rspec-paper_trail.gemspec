# -*- encoding: utf-8 -*-

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rspec/paper_trail/version'

Gem::Specification.new do |spec|
  spec.name          = 'rspec-paper_trail'
  spec.version       = Rspec::PaperTrail::VERSION
  spec.authors       = ['Paul Belt']
  spec.email         = %w(paul.belt@gmail.com)
  spec.description   = %q{use paper_trail within rspec, conveniently}
  spec.summary       = %q{provides rspec-matcher to ensure versioning and per-spec, per-block versioning}
  spec.homepage      = 'https://github.com/belt/rspec-paper_trail'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = %w(lib)

  spec.required_ruby_version = Gem::Requirement.new('>= 1.9.2')
  spec.required_rubygems_version = Gem::Requirement.new('>= 0') if spec.respond_to? :required_rubygems_version=

  if spec.respond_to? :specification_version
    spec.specification_version = 3
    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0')
      spec.add_runtime_dependency 'paper_trail', ['~> 2.7.1']
      spec.add_runtime_dependency 'rspec', ['~> 2.13.0']

      spec.add_development_dependency 'bundler', ['~> 1.3.0']
      spec.add_development_dependency 'rake'
    else
      spec.add_dependency 'paper_trail', ['~> 2.7.1']
      spec.add_dependency 'rspec', ['~> 2.13.0']
      spec.add_dependency 'bundler', ['~> 1.3']
      spec.add_dependency 'rake'
    end
  else
    spec.add_dependency 'paper_trail', ['~> 2.7.1']
    spec.add_dependency 'rspec', ['~> 2.13.0']
    spec.add_dependency 'bundler', ['~> 1.3']
    spec.add_dependency 'rake'
  end

end
