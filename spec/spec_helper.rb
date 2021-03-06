ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'turnip/capybara'

ActiveRecord::Migration.maintain_test_schema!

paths = Dir[Rails.root.join('spec/**/{support,step_definitions}/**/*.rb')]
paths.each { |file| require file }

Capybara.javascript_driver = :webkit

RSpec.configure do |config|
  config.use_transactional_fixtures = false

  config.include Rails.application.routes.url_helpers
  config.include EmailSpec::Helpers
  config.include EmailSpec::Matchers
  config.include FactoryBot::Syntax::Methods

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before do
    ActionMailer::Base.deliveries.clear
  end
end
