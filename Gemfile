source 'http://rubygems.org'


# Add following two lines to your ~/.gemrc or /etc/gemrc:
# install: --no-rdoc --no-ri
# update:  --no-rdoc --no-ri

platforms :ruby_20, :ruby_21 do
  gem 'byebug'
  gem 'rb-readline'
end

# Windows specific
platforms :mswin, :mingw do
  gem 'win32console'
  gem 'term-ansicolor'
end


# Install all the webdriver gems and cucumber
# Lock selenium-webdriver into a known supported version.
gem 'cucumber'
gem 'selenium-webdriver'
gem 'watir'

# LapisLazul itself
gem 'lapis_lazuli'
