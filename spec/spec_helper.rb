require 'rspec'
require 'webmock/rspec'
require 'pry'
require 'pivotal_tracker_api'
# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}
API_URL = PivotalTrackerApi::API.const_get("API_URL")

RSpec.configure do |config|

  # Allow focus on a specific test if specified
  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true
end