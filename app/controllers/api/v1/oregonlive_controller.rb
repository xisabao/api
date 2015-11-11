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

def iso_time(param)
  military_time = param[/(?<=T)\d+/]
  time = Time.strptime( military_time , '%H%M%S').strftime('%I:%M %P')
  #setup the date
  date = DateTime.parse(param).iso8601
  date = Time.parse(date).strftime("%m/%d/%Y")

  return date + " " + time

  end

  def event_submit(params)
    @log = ""

    #initialize the log
    @log = ""
    #set the browser that we will use to chrome for testing
    browser = Watir::Browser.new

    #give the driver a url to visit
    browser.goto "http://myevent.oregonlive.com/web/event.php"
    @log += browser.title

    browser.text_field(:name => "EventTitle").wait_until_present

    @log += "\n" + "title: #{params[:event_title]}"
    browser.text_field(:name => 'EventTitle').set nul_check(params[:event_title])

    puts "category"
    @log += "\n" + "url: #{params[:category]}"
    browser.select_list(:id => 'CategoryID').option(:text => "Books").select

    #venue
    @log += "\n" + "venue : #{params[:venue]}"
    browser.text_field(:name => 'EventVenueSearch').set nul_check(params[:venue])
    browser.element(:class => "ui-menu-item").wait_until_present
    browser.send_keys :tab

    #date
    puts "date"
    date_time = iso_time(params[:dtstart])
    #split the time out of the date string as well
    @log += "\n" + "date: #{date_time}"
    browser.text_field(:name => 'EventDateString').set date_time

    puts "description"
    @log += "\n" + "description: #{params[:body_text]}"
    browser.text_field(:name => 'EventLongDescription').set nul_check(params[:body_text])

    puts "price"
    @log += "\n" + "price: #{params[:price]}"
    if (params[:price] = "")
      price = "free"
    else
      price = params[:price]
    end
    browser.text_field(:name => 'EventPrice').set price

    puts "phone"
    @log += "\n" + "phone: #{params[:phone]}"
    browser.text_field(:name => 'EventPhoneNumber').set nul_check(params[:phone])

    puts "url"
    @log += "\n" + "url: #{params[:url]}"
    browser.text_field(:name => 'EventURL').set nul_check(params[:url])

    puts "name"
    @log += "\n" + "name: #{params[:first_name] + " " + params[:last_name]}"
    name = nul_check(params[:first_name]) + " " + nul_check(params[:last_name])
    browser.text_field(:name => 'EventCustomAttrib198').set name

    puts "phone"
    @log += "\n" + "phone: #{params[:phone]}"
    browser.text_field(:name => 'EventCustomAttrib199').set nul_check(params[:phone])

    puts "email"
    @log += "\n" + "email: #{params[:email]}"
    browser.text_field(:name => 'EventCustomAttrib200').set nul_check(params[:email])

    client = DeathByCaptcha.new('cga', 'codeguild2015', :http)


    if browser.img(:id, 'recaptcha_challenge_image').exists?
      @log += "\n recaptcha"
      captcha_url = browser.image(:id => 'recaptcha_challenge_image').src
      captcha = client.decode!(url: captcha_url)
      browser.text_field(:id => 'recaptcha_response_field').set captcha.text
    else
      @log += "\n security image"
      browser.div(:id => 'Security_Image').screenshot('captcha_image.png')
      captcha = client.decode!(path: 'captcha_image.png')
      browser.text_field(:id => 'security_code').set captcha.text
      File.delete('captcha_image.png')
    end

    #make the submission
    browser.button(:value => "Preview").click

    if browser.div(:class => "suportLinkContainer").exists?
      @log += "Errors!  " + browser.div(:class => "suportLinkContainer").text
    elsif browser.text.include? "If all the information below is accurate, click \"Submit\" below."
      browser.button(:id => "Submit_Event").click
      @log += "\nSubmitted event!"
    end

    #browser.quit

  end

end
