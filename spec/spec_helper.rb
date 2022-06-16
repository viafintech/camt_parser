# encoding: utf-8

Dir[File.dirname(__FILE__) + '/../lib/*.rb'].each  { |file| require file }
Dir["./spec/support/**/*.rb"].each { |file| require file }

RSpec.configure do |config|
  # rspec-expectations config goes here. You can use an alternate
  # assertion/expectation library such as wrong or the stdlib/minitest
  # assertions if you prefer.
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  # This setting enables warnings. It's recommended, but in some cases may
  # be too noisy due to issues in dependencies.
  config.warnings = true

  config.disable_monkey_patching!
end
