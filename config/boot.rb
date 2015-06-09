ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler' # Set up gems listed in the Gemfile.
env = ENV['RAILS_ENV'] || :development
Bundler.setup(:default, env)