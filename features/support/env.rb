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
require 'lapis_lazuli'
require 'lapis_lazuli/cucumber'

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
#browser = Watir::Browser.new (ENV['BROWSER'] || 'firefox').downcase

LapisLazuli::WorldModule::Config.config_file = "config/config.yml"
World(LapisLazuli)

# Returns the error as a string if one is detected
# Here you can also insert custom checks. E.g detect if there is any error box and pass the content
def error_on_page?
  begin
    page_text = browser.html
    CONFIGS['error_strings'].each do |error|
      if page_text.scan(error)[0]
        return page_text.scan(error)[0]
      end
    end
  rescue
   $log.debug "Cannot read html for page #{browser.url}"
  end
  return false
end

# Actions that will happen before every scenario
LapisLazuli.Before do
  # things that should be run before every run
end

# This is executed after every step.
LapisLazuli.After do
  #Check if one of the error strings from the config file is detected on the page
  errors_on_page = error_on_page?
  if errors_on_page
    raise "'#{errors_on_page}' found on <a href='#{browser.url}' target='_blank'>page</a>"
  end

  #Wait the required time
  sleep CONFIGS['step_pause_time'] rescue sleep 0
end

