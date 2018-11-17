ENV['RUBY_ENV'] = 'test'
# require 'bundler'
Bundler.require(:default, :test)
Dotenv.load('.env.test')

# require 'json_expressions/rspec'

require 'factory_bot'
require 'database_cleaner'

require_relative '../application'

RSpec.configure do |config|
  DatabaseCleaner.strategy = :transaction

  config.include FactoryBot::Syntax::Methods

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.before(:suite) do
    FactoryBot.define { to_create(&:save) }
    FactoryBot.find_definitions
    DatabaseCleaner.start
  end

  config.after(:suite) do
    DatabaseCleaner.clean
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
