source 'http://rubygems.org'

# Specify your gem's dependencies in rspec-paper_trail.gemspec
if RbConfig::CONFIG['RUBY_PROGRAM_VERSION'] == '1.9.3'
  gem 'debugger'
elsif %w(1.9.0 1.9.1 1.9.2).include?(RbConfig::CONFIG['RUBY_PROGRAM_VERSION'])
  gem 'ruby-debug19', :require => 'ruby-debug'
else
  gem 'ruby-debug'
end

gemspec
