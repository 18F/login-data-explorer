RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
    DatabaseCleaner[:active_record, { model: Idp::IdpRecord }].clean_with(:truncation)
  end

  config.before(:each) do
    # set the default
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner[:active_record, { model: Idp::IdpRecord }].strategy = :transaction
  end

  config.before(:each) do
    DatabaseCleaner.start
    DatabaseCleaner[:active_record, { model: Idp::IdpRecord }].start
  end

  config.append_after(:each) do
    DatabaseCleaner.clean
    DatabaseCleaner[:active_record, { model: Idp::IdpRecord }].clean
  end
end
