require 'capybara/rspec'

RSpec.configure do |config|
  # see more settings at spec/rails_helper.rb
  config.raise_errors_for_deprecations!
  config.order = :random
  config.color = true

  # allows you to run only the failures from the previous run:
  # rspec --only-failures
  config.example_status_persistence_file_path = './tmp/rspec-examples.txt'
end
