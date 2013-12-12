################################################################################
# Link validators

Then /^I should see link "([^"]*)"$/ do |arg1|
  link_visible = false
  links = $BROWSER.as(:text => /#{arg1}/i)
  links.each do |link|
    if link.visible?
      link_visible = true
      break
    end
  end
  
  handle_element_not_found("link", arg1) unless link_visible
end

Then /^I should not see link "([^"]*)"$/ do |arg1|
	if $BROWSER.link(:text => arg1).exist? and $BROWSER.link(:text => arg1).visible?
    raise "Link ''#{arg1}'' is visible"
  end
end

################################################################################
# Text validators

Then /^I should see text "([^"]*)"$/ do |arg1|
  match_found = /#{arg1}/.match($BROWSER.html)
  raise "Text '#{arg1}' found on page" unless match_found
end


Then /^I should not see text "([^"]*)"$/ do |arg1|
  match_found = /#{arg1}/.match($BROWSER.html)
  raise "Text '#{arg1}' found on page" if match_found
end


################################################################################
# Other validators

Then /^I take a screenshot$/ do
  begin
    filename = File.join($SCREENSHOTS_DIR, $scenario_name + '.jpg')
    $BROWSER.driver.save_screenshot(filename)
    $log.debug "Screenshot saved: #{filename}"
  rescue Exception => e
    puts "Failed to save screenshot. Error message: '#{e.message}'"
    $log.debug "Failed to save screenshot. Error message: '#{e.message}'"
  end
end

Then /^I should see image from source "([^"]*)"$/ do |arg1|
  if !$BROWSER.img(:src => /#{arg1}/).exist?
    raise "Image '#{arg1}' not found"
  elsif !$BROWSER.img(:src => /#{arg1}/).visible?
    handle_element_not_found('visible image', arg1)
  end
end

Then /^I should see button "([^\"]*)"$/ do |arg1|
  handle_element_not_found('button', arg1) unless find_button(arg1, 5)
end

Then /^field "([^"]*)" has value "([^"]*)"$/ do |arg1, arg2|
  text_field_found = false
  text_fields = $BROWSER.text_fields
  text_fields.each do |text_field|
    if text_field.html.include? arg1
      text_field_found = true
      if !text_field.value.include? arg2
        raise "Text field '#{arg1}' has value '#{text_field.value}'"
      end
    end
  end
  raise "Text field '#{arg1}' not found" unless text_field_found
end

################################################################################
# Checkbox validators

Given /^checkbox "(.*?)" is set$/ do |arg1|
  checkbox_found = false
  checkboxes = $BROWSER.checkboxes
  checkboxes.each do |checkbox|
    #usually parent contains the label information
    if checkbox.html.include? arg1
      checkbox_found = true
      raise "Checkbox #{arg1} is set" unless checkbox.set?
    end
  end
  raise "Checkbox '#{arg1}' not found" unless checkbox_found
end

Given /^checkbox "(.*?)" is cleared$/ do |arg1|
  checkbox_found = false
  checkboxes = $BROWSER.checkboxes
  checkboxes.each do |checkbox|
    #usually parent contains the label information
    if checkbox.html.include? arg1
      checkbox_found = true
      raise "Checkbox #{arg1} is set" if checkbox.set?
    end
  end
  raise "Checkbox '#{arg1}' not found" unless checkbox_found
end