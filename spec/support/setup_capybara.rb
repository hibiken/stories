require 'capybara/rails'
require 'capybara/rspec'

Capybara.app = Rack::Builder.parse_file(File.expand_path('../../../config.ru', __FILE__)).first 

require "selenium/webdriver"

Capybara.register_driver :chrome do |app|

  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    chromeOptions: { args: %w(disable-gpu auto-open-devtools-for-tabs) }
  )

  Capybara::Selenium::Driver.new(app, browser: :chrome, desired_capabilities: capabilities)
end

Capybara.register_driver :headless_chrome do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    chromeOptions: { args: %w(headless disable-gpu auto-open-devtools-for-tabs) }
  )

  Capybara::Selenium::Driver.new app,
    browser: :chrome,
    desired_capabilities: capabilities
end

Capybara.javascript_driver = ENV['CODESHIP'].present? ? :headless_chrome : :chrome

# Capybara.default_max_wait_time = 300
