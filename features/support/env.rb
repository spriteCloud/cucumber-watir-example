################################################################################################
# Created by spriteCloud B.V. (R)
# For info and questions: support@spritecloud.com
################################################################################################
require 'rubygems'
require 'selenium-webdriver'
require 'watir-webdriver'
require "watir-webdriver/extensions/alerts"
require 'logger'
require 'uri'
require 'time'

###################################################################################
# Start the logger
$log = Logger.new('log/selenium.log')

###################################################################################
# Read the config file (load config_local.yml if it exists)
begin
  CONFIGS = YAML.load_file("config/config_local.yml")
rescue
  CONFIGS = YAML.load_file("config/config.yml")
end

###################################################################################
# Load the global variables
$T_START = Time.now

###################################################################################
# Launch the browser. Can be firefox, chrome, safari or ie. Defaults to firefox
# Define what browser to use from cucumber yml or from the command line using BROWSER=<..>.
$BROWSER = Watir::Browser.new (ENV['BROWSER'] || 'firefox').downcase

# Returns the error as a string if one is detected
# Here you can also insert custom checks. E.g detect if there is any error box and pass the content
def error_on_page?
  begin
    page_text = $BROWSER.html
    CONFIGS['error_strings'].each do |error|
      if page_text.scan(error)[0]
        return page_text.scan(error)[0]
      end
    end
  rescue
   $log.debug "Cannot read html for page #{$BROWSER.url}"
  end
  return false
end

# Actions that will happen before every scenario
Before do |scenario|
  # $scenario_name is a unique (filename compatible) scenario identifier. Can be used as screenshot filename.
  # All non alphanumeric characters are replaced and whitespaces are replaced with underscores
  $scenario_name = Time.now.strftime('%y%m%d_%H%M%S') + "_" + scenario.name.gsub(/^.*(\\|\/)/, '').gsub(/[^\w\.\-]/, '_').squeeze('_').chomp('_')
end

# This is executed after every step.
AfterStep do |scenario|
  #Check if one of the error strings from the config file is detected on the page
  errors_on_page = error_on_page?
  if errors_on_page
    raise "'#{errors_on_page}' found on <a href='#{$BROWSER.url}' target='_blank'>page</a>"
  end

  #Wait the required time
  sleep CONFIGS['step_pause_time'] rescue sleep 0
end

# This is executed after every scenario.
After do |scenario|
  if scenario.failed? and CONFIGS['screenshot_on_failed_scenario']
    begin
      filename = File.join(CONFIGS['screenshots_dir'], $scenario_name + '.jpg')
      $BROWSER.driver.save_screenshot(filename)
      $log.debug "Screenshot saved: #{filename}"
    rescue Exception => e
      puts "Failed to save screenshot. Error message: '#{e.message}'"
      $log.debug "Failed to save screenshot. Error message: '#{e.message}'"
    end
  end
end

# Closing the browser after the test.
at_exit do
  $BROWSER.close
end