require 'capybara'
require 'capybara/cucumber'
require 'capybara/poltergeist'

Capybara.configure do |config|
  config.default_driver = :poltergeist
  config.app_host   = 'https://duckduckgo.com'
end

# Capture javascript errors in Cucumber + Capybara + Webdriver tests
# We need a firefox extension(JSErrorCollector) to start intercepting javascript errors before the page
# scripts load
Capybara.register_driver :selenium do |app|
  profile = Selenium::WebDriver::Firefox::Profile.new
  # see https://github.com/mguillem/JSErrorCollector
  profile.add_extension File.join(Rails.root, "features/support/extensions/JSErrorCollector.xpi")
  Capybara::Selenium::Driver.new app, :profile => profile
end

After do |scenario|
  if page.driver.to_s.match("Selenium")
    errors = page.execute_script("return window.JSErrorCollector_errors.pump()")

    if errors.any?
      puts '-------------------------------------------------------------'
      puts "Found #{errors.length} javascript #{pluralize(errors.length, 'error')}"
      puts '-------------------------------------------------------------'
      errors.each do |error|
        puts "    #{error["errorMessage"]} (#{error["sourceName"]}:#{error["lineNumber"]})"
      end
      raise "Javascript #{pluralize(errors.length, 'error')} detected, see above"
    end

  end
end
