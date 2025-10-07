ASpaceGems.setup if defined? ASpaceGems

source 'https://rubygems.org'

gem 'chronic', '~> 0.10.2'

def running_in_aspace?
  defined?(AppConfig) || ENV['ASPACE_LAUNCHER_BASE']
end

unless running_in_aspace?
  gem 'rspec'
end
