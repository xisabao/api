require "selenium-webdriver"
require "rubygems"

#set the browser that we will use to chrome for testing
driver = Selenium::WebDriver.for(:chrome)

#give the driver a url to visit
driver.navigate.to "https://www.spingo.com/submit/info?eventType=promote"

#this block makes the driver wait till the page is loaded before continuing on.
wait = Selenium::WebDriver::Wait.new(:timeout => 20)
wait.until { driver.find_element(:id => "title") }

#output the title to the console so that we can confirm what we're working on
puts driver.title

#Spin-Go Specific automation
#each of the following finds an element, by one of several means and enters a value
#it still needs to be tied into the events model from the existing app. For not all
#data is hard coded.

#title
driver.find_element(:id, 'title').send_keys('Test Title')

#venue
driver.find_element(:id, 'venue').send_keys('Test, ')
sleep 2
driver.find_element(:id, 'venue').send_keys(:arrow_down, :return)

#class date-picker-input
driver.find_element(:class, 'date-picker-input').send_keys("Dec 17, 2015")

#class time-picker-input
driver.find_element(:class, 'time-picker-input').send_keys('11:00am', :tab, '2:00pm')

#description
driver.find_element(:id, 'description').send_keys('This is a detailed description.')

#attendance - 1-50, 50-100, 100-250, 250-500, 500-1000, 1000-2500, 2500+
select = driver.find_element(:id, 'attendance')
options = select.find_elements(:tag_name, 'option')
options.each do |option|
  if option.text == '1 - 50'
    option.click
  end
end

#category - dropdown
select = driver.find_element(:id, 'category')
options = select.find_elements(:tag_name, 'option')
options.each do |option|
  if option.text == 'Business'
    option.click
  end
end
# <div class="select-wrapper"><select> "admission" -> price
admission = driver.find_elements(:tag_name, 'option')
admission.each do |element|
  if element.text == "Price"
    element.click
  end
end

# then the price element
wait.until { driver.find_element(:css, 'input[ng-model="ctrl.type.value[0].price"]') }
driver.find_element(:css, 'input[ng-model="ctrl.type.value[0].price"]').send_keys('12')

#button next
buttons = driver.find_element(:tag_name, 'button')

if buttons.text == "NEXT"
  buttons.click
end
#page 2
#media
wait.until { driver.find_element(:css, 'input[ng-model="imageUrl"]') }
driver.find_element(:css, 'input[ng-model="imageUrl"]').send_keys('http://test.url')

#event contact
driver.find_element(:css, 'input[ng-model="vm.form.formData.basicInfo.phone"]').send_keys('5551234567')
#event email
driver.find_element(:css, 'input[ng-model="vm.form.formData.basicInfo.email"]').send_keys('example@example.com')

#if personal != event
driver.find_element(:css, 'label[ng-model="vm.sameContact').click

#submitter phone
driver.find_element(:css, 'input[ng-model="vm.form.formData.submitter.phone"]').send_keys('5552345678')
#submitter email
driver.find_element(:css, 'input[ng-model="vm.form.formData.submitter.email"]').send_keys(:control, :backspace, 'example@example.com')
#submitter name
driver.find_element(:css, 'input[ng-model="vm.form.formData.submitter.name"]').send_keys('Jon Doe')

#don't send me news
driver.find_element(:css, 'label[ng-model="vm.form.formData.interests.newsletter"]').click

#submit
#driver.find_element(:css, 'button[type="submit"]').click

#quit the driver
driver.quit



