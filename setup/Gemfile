source 'http://rubygems.org'

# Add following two lines to your ~/.gemrc or /etc/gemrc:
# install: --no-rdoc --no-ri
# update:  --no-rdoc --no-ri

# Install helper libraries
gem 'rspec'
gem 'gherkin'
gem 'xml-simple'
gem 'mechanize'

# Install all the webdriver gems and cucumber
gem 'watir-webdriver'
gem 'watir-webdriver-performance'
gem 'cucumber'
# For spriteCloud portal support, install the local spriteCloud gem. Get it from https://portal.spritecloud.com/api
#gem 'cucumber-spriteCloud', '0.9.0.6', :path => '.'

#Windows specific
platforms :mswin, :mingw do
  gem 'win32console'
  gem 'term-ansicolor'
end

#ruby version specific gems
platforms :ruby_19 do
  gem 'debugger'
end
