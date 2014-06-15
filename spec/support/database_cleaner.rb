RSpec.configure do |config|
  # Run JS tests with truncation, not transactions,
  # otherwise the data we set up may not be visible inside the
  # headless browser running the tests.

  config.use_transactional_fixtures = false

  config.before :each, js: true do
    DatabaseCleaner.strategy = :truncation
  end

  config.before :each, js: false do
    DatabaseCleaner.strategy = :transaction
  end

  config.before :each do
    DatabaseCleaner.start
  end

  config.after :each do
    DatabaseCleaner.clean
  end
end
