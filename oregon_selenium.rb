class Api::V1::OregonliveController < ApplicationController
  respond_to :json

  def index
    respond_with "oregon live"
  end

  def create

    event_submit(params[:json_event])

    respond_to do |format|
      if ( @log.present? )
        format.json { render text: "Log: " + @log }
      else
        format.json { render text: "Error, no log" }
      end
    end

  end

  def nul_check(param)
    param ||= "none"
    return param
  end

  def event_submit(params)
    @log = ""

    headless = Headless.new
    headless.start

    #initialize the log
    @log = ""
    #set the browser that we will use to chrome for testing
    driver = Selenium::WebDriver.for(:firefox)

    #give the driver a url to visit
    driver.navigate.to "http://myevent.oregonlive.com/web/event.php"

    #this block makes the driver wait till the page is loaded before continuing on.
    wait = Selenium::WebDriver::Wait.new(:timeout => 20)
    wait.until { driver.find_element(:name, "EventTitle") }

    #Oregon Live Specific automation
    #each of the following finds an element, by one of several means and enters a value

    #title
    puts "title"
    @log += "\n" + "title: #{params[:event_title]}"
    driver.find_element(:name, 'EventTitle').send_keys(nul_check(params[:event_title]))
    #category
    #is an array use the first element when you come back to this

    #location
    puts "location"
    @log += "\n" + "location: #{params[:location]}"
    driver.find_element(:name, 'EventVenueSearch').send_keys(nul_check(params[:location]))

    #date
    puts "date"
    @log += "\n" + "date: #{params[:dtstart].to_date}"
    driver.find_element(:name, 'EventDateString').send_keys(params[:dtstart].to_date)

    puts "description"
    @log += "\n" + "description: #{params[:body_text]}"
    driver.find_element(:name, 'EventLongDescription').send_keys(nul_check(params[:body_text]))

    puts "price"
    @log += "\n" + "price: #{params[:price]}"
    if (params[:price] = "")
      price = "free"
    else
      price = params[:price]
    end
    driver.find_element(:name, 'EventPrice').send_keys(price)

    puts "phone"
    @log += "\n" + "phone: #{params[:phone]}"
    driver.find_element(:name, 'EventPhoneNumber').send_keys(nul_check(params[:phone]))

    puts "url"
    @log += "\n" + "url: #{params[:url]}"
    driver.find_element(:name, 'EventURL').send_keys(nul_check(params[:url]))

    puts "name"
    @log += "\n" + "name: #{params[:first_name] + " " + params[:last_name]}"
    name = nul_check(params[:first_name]) + " " + nul_check(params[:last_name])
    driver.find_element(:name, 'EventCustomAttrib198').send_keys(name)

    puts "phone"
    @log += "\n" + "phone: #{params[:phone]}"
    driver.find_element(:name, 'EventCustomAttrib199').send_keys(nul_check(params[:phone]))

    puts "email"
    @log += "\n" + "email: #{params[:email]}"
    driver.find_element(:name, 'EventCustomAttrib200').send_keys(nul_check(params[:email]))

    puts "email"
    @log += "\n" + "email: #{params[:email]}"
    driver.find_element(:name, 'EventCustomAttrib200').send_keys(nul_check(params[:email]))

    #captcha
    client = DeathByCaptcha.new('cga', 'codeguild2015', :http)

    if browser.img(:id, 'recaptcha_challenge_image').exists?
      captcha_url = driver.image(:id => 'recaptcha_challenge_image').src
      captcha = client.decode!(url: captcha_url)
      browser.text_field(:id => 'recaptcha_response_field').set captcha.text
      driver.find_element(:name, 'security_code').send_keys(captcha.text)
    else
      browser.div(:id => 'Security_Image').screenshot('captcha_image.png')
      captcha = client.decode!(path: 'captcha_image.png')
      driver.find_element(:name, 'security_code').send_keys(captcha.text)
      File.delete('captcha_image.png')
    end

  end

end
