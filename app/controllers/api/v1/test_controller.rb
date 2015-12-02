class Api::V1::TestController < ApplicationController
  respond_to :json

  def index
    respond_with "hello again"
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
    #set the browser that we will use to chrome for testing
    browser = Watir::Browser.new

    #give the driver a url to visit
    browser.goto "http://myevent.oregonlive.com/web/event.php"

    def check(browser)
      if browser.text.include? "Enter the day"
        puts "it had the text"
      else
        puts "not working"
      end
    end

    check browser

  end

end
