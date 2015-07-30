class Api::V1::AutomationController < ApplicationController
  respond_to :json

  def index
    respond_with "hello again"
    #system("ruby automations/test.rb")
    headless = Headless.new
    headless.start
    b = Watir::Browser.start 'www.google.com'
    puts b.title
    b.close
    headless.destroy

  end

end
