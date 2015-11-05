require 'watir-webdriver'
require 'headless'
puts "driving now"

headless = Headless.new
headless.start
profile = Selenium::WebDriver::Firefox::Profile.new
profile.proxy = Selenium::WebDriver::Proxy.new :http => 'my.proxy.com:8080', :ssl => 'my.proxy.com:8080'
browser = Watir::Browser.new :firefox, :profile => profile
b = Watir::Browser.start 'http://myevent.oregonlive.com/web/event.php'
puts b.title
b.close
headless.destroy
