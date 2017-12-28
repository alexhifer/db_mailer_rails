ENV['RAILS_ENV'] ||= 'test'

require 'bundler/setup'
require 'action_controller'
require 'active_record'
require 'action_view'
require 'db_mailer_rails'

require 'shoulda-matchers'
require 'factory_bot'
require 'generator_spec'
require 'database_cleaner'

# load test app environment
require 'rails_app/config/environment'
load File.expand_path('../rails_app/db/schema.rb', __FILE__)

# load support folder
Dir[File.expand_path('spec/support/**/*.rb')].each { |file| require file }

RSpec.configure do |config|
  config.include(Shoulda::Matchers::ActiveModel, type: :model)
  config.include(Shoulda::Matchers::ActiveRecord, type: :model)

  config.include FactoryBot::Syntax::Methods

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:suite) do
    FactoryBot.find_definitions

    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with :truncation
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning { example.run }
  end
end
