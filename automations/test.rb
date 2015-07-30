require 'rubygems'
require 'selenium-webdriver'
require 'headless'

puts 'Driving Now'


Headless.ly do
  driver = Selenium::WebDriver.for(:firefox)
  driver.get 'http://google.com'
  puts driver.title
end
driver.quit
