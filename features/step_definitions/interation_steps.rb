################################################################################
# Navigating functions

Given /^I navigate to url "([^"]*)"$/ do |arg1|
  if arg1 =~ /^#{URI::regexp}$/
   $BROWSER.goto arg1
  else
    raise "Not a valid URL: #{arg1}"
end
end

Given /^I click on the back button of the browser$/ do
  $BROWSER.back
end

When /^I wait for (\d+) seconds$/ do |arg1|
  sleep(arg1.to_i)
end

################################################################################
# Link interaction steps

When /^I click on link "([^"]*)"$/ do |arg1|
  begin
    $BROWSER.a(:text => /#{arg1}/i).click
  rescue
    raise "Link '#{arg1}' not found"
  end
end

################################################################################
# button interaction steps

Then /^I click on button "([^\"]*)"$/ do |arg1|
  #HTML elements 'button' and 'input' are most used for a button
  if $BROWSER.button(:text => /#{arg1}/i).exist?
    $BROWSER.button(:text => /#{arg1}/i).click
  elsif $BROWSER.input(:value => /#{arg1}/i).exist?
    $BROWSER.input(:value => /#{arg1}/i).click
  else
    raise "Button '#{arg1}' not found"
  end
end

################################################################################
# Input field interaction steps

Then /^I use value "([^"]*)" for field "([^"]*)"$/ do |arg1, arg2|
  text_field_found = false
  text_fields = $BROWSER.text_fields
  text_fields.each do |text_field|
    if text_field.html.include? arg2
      text_field_found = true
      text_field.clear rescue raise "Warning. failed to clear text field #{arg2}"
      text_field.send_keys(arg1)
    end
  end
  raise "Text field '#{arg1}' not found" unless text_field_found
end

################################################################################
# Checkbox interaction steps

Given /^I set checkbox "(.*?)"$/ do |arg1|
  checkbox_found = false
  checkboxes = $BROWSER.checkboxes
  checkboxes.each do |checkbox|
    #usually parent contains the label information
    if checkbox.html.include? arg1
      checkbox_found = true
      checkbox.set
    end
  end
  raise "Checkbox '#{arg1}' not found" unless checkbox_found
end

Given /^I clear checkbox "(.*?)"$/ do |arg1|
  checkbox_found = false
  checkboxes = $BROWSER.checkboxes
  checkboxes.each do |checkbox|
    #usually parent contains the label information
    if checkbox.html.include? arg1
      checkbox_found = true
      checkbox.clear
    end
  end
  raise "Checkbox '#{arg1}' not found" unless checkbox_found
end

