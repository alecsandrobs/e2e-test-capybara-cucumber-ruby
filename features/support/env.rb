# require 'cucumber'
require 'capybara/cucumber'
require 'selenium-webdriver'
require 'chromedriver-helper'
require 'rest-client'
require 'allure-cucumber'
require 'webdrivers'

AllureCucumber.configure do |config|
    config.logging_level = Logger::INFO
end

BROWSER = ENV['BROWSER'].nil? ? 'chrome' : ENV['BROWSER']
CONTEXTO = ENV['CONTEXTO'].nil? ? ENV['CONTEXTO'] : 'producao'
CONFIG = YAML.load_file(File.dirname(__FILE__) + "/contextos/#{CONTEXTO}.yml")
HEADLESS = !ENV['HEADLESS'].nil? && ENV['HEADLESS'].eql?('sim')
DRIVER_PATH = 'features/support/webdrivers/'
REPORT_PATH = 'report/'

FileUtils.mkdir_p REPORT_PATH unless File.exists?(REPORT_PATH)
FileUtils.mkdir_p DRIVER_PATH unless File.exists?(DRIVER_PATH)

Webdrivers.install_dir = DRIVER_PATH

# if RUBY_PLATFORM =~ /win32/
#   caminho_path = "#{FileUtils.pwd()}\\features\\support\\drivers\\geckodriver-v0.29.1-win64.exe"
#   ENV['SO'] = 'Windows'
# elsif RUBY_PLATFORM =~ /linux/
#   caminho_path = "#{FileUtils.pwd()}/features/support/drivers/geckodriver-v0.29.1-linux64"
#   ENV['SO'] = 'Linux'
# elsif RUBY_PLATFORM =~ /darwin/
#   caminho_path = "#{FileUtils.pwd()}/features/support/drivers/geckodriver-v0.29.1-macos-aarch64"
#   ENV['SO'] = 'IOs'
# else
#   puts '####### Sistema operacional inválido #######'
# end

# puts BROWSER
# def get_driver
#     if BROWSER.eql?('chrome')
#         if HEADLESS
#             return :selenium_chrome_headless
#         else
#             return :selenium_chrome
#         end
#     elsif BROWSER.eql?('firefox')
#         return :selenium
#     end
# end

# Capybara.register_driver :selenium do |app|
#     if BROWSER.eql?('firefox')
#         Selenium::WebDriver::Firefox::Service.driver_path  = caminho_path
#         options = ::Selenium::WebDriver::Firefox::Options.new
#         if HEADLESS
#             options.args << '--headless'
#         end
#         Capybara::Selenium::Driver.new(app, :browser => :firefox, :marionette => true, options: options)
#     end
# end

Capybara.register_driver :headless_firefox do |app|
    Capybara::Selenium::Driver.load_selenium
    browser_options = ::Selenium::WebDriver::Firefox::Options.new
    browser_options.args << '-headless'
    Capybara::Selenium::Driver.new(app, browser: :firefox, options: browser_options)
end
  
Capybara.register_driver :headless_chrome do |app|
    Capybara::Selenium::Driver.load_selenium
    browser_options = ::Selenium::WebDriver::Chrome::Options.new.tap do |opts|
        opts.args << '--headless'
        opts.args << '--disable-gpu' if Gem.win_platform?
        # Workaround https://bugs.chromium.org/p/chromedriver/issues/detail?id=2650&q=load&sort=-id&colspec=ID%20Status%20Pri%20Owner%20Summary
        opts.args << '--disable-site-isolation-trials'
    end
    Capybara::Selenium::Driver.new(app, browser: :chrome, options: browser_options)
end

def get_driver(browser)
    driver = case browser
        when 'chrome' then HEADLESS ? :headless_chrome : :selenium_chrome
        # when 'chrome' then HEADLESS ? :selenium_chrome_headless : :selenium_chrome
        when 'firefox' then HEADLESS ? :headless_firefox : :selenium
        when 'internet-explorer' then puts "The browser (#{browser}) was not setup yet."
        when 'edge' then "The browser (#{browser}) was not setup yet."
        else "The argument (#{browser}) is an invalid browser."
    end
    return driver
end

Capybara.configure do |config|
    # config.default_driver = :selenium
    config.default_driver = get_driver(BROWSER)
    config.app_host = CONFIG['url']
    config.default_max_wait_time = 15
end

Capybara.current_session.driver.browser.manage.window.resize_to(1920, 1080)