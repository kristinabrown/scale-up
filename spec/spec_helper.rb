require "capybara/rspec"
require "rails_helper"
require "factory_girl_rails"
require "support/factory_girl"


RSpec.configure do |config|
  if Bullet.enable?
    config.before(:each) do
      Bullet.start_request
    end
  
    config.after(:each) do
      Bullet.perform_out_of_channel_notifications if Bullet.notification?
      Bullet.end_request
    end
  end
  
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.include Rails.application.routes.url_helpers

  config.color = true

  config.tty = true
  config.after(:suite) do
    FileUtils.rm_rf(Dir["#{Rails.root}/spec/test_files/"])
  end
end
