class Api::V1::AutomationController < ApplicationController
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
    @log = ""

    headless = Headless.new
    headless.start

    #initialize the log
    @log = ""
    #set the browser that we will use to chrome for testing
    driver = Selenium::WebDriver.for(:firefox)

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
    puts "title"
    @log += "\n" + "title: #{params[:body]}"
    driver.find_element(:id, 'title').send_keys(params[:body])

    #venue
    puts "venue"
    @log += "\n" + "venue"
    driver.find_element(:id, 'venue').send_keys("a")
    sleep 2
    puts "can't find your venue"
    driver.find_element(:xpath, "/html/body/div[1]/div/div[1]/div[2]/div/div[1]/ng-form/ui-view/div/form/div[3]/div/div[1]/div/div/div/div/div").click
    sleep 2
    puts "venue title"
    @log += "\n" + "venue title: #{params[:venue]}"
    driver.find_element(:id, 'venueTitle').send_keys(nul_check(params[:venue]))
    @log += "\n" + "venue address: #{params[:address]}"
    driver.find_element(:name, 'venueStreet').send_keys(nul_check(params[:address]))
    sleep 1
    puts "venue city"
    @log += "\n" + "venue city: #{params[:city]}"
    driver.find_element(:name, 'venueCity').send_keys(nul_check(params[:city]))
    sleep 1
    puts "venue state"
    @log += "\n" + "venue state: #{params[:state]}"
    driver.find_element(:name, 'venueState').clear()
    sleep 1
    driver.find_element(:name, 'venueState').send_keys(nul_check(params[:state]))
    puts 'venue state'
    sleep 1
    driver.find_element(:name, 'venuePostalCode').clear()
    puts 'venue postal code'
    @log += "\n" + "venue postal code: #{params[:postal_code]}"
    sleep 1
    driver.find_element(:name, 'venuePostalCode').send_keys(nul_check(params[:postal_code]))

    #class date-picker-input
    puts 'date picker'
    @log += "\n" + "date picker: #{"???"}"
    driver.find_element(:class, 'date-picker-input').send_keys("Dec 17, 2015")

    #class time-picker-input
    puts 'time picker'
    @log += "\n" + "time picker: #{"???"}"
    driver.find_element(:class, 'time-picker-input').send_keys('11:00am', :tab, '2:00pm', :tab)

    #description
    puts 'description'
    @log += "\n" + "date picker: #{params[:body_text]}"
    driver.find_element(:id, 'description').send_keys(nul_check(params[:body_text]))

    #attendance - 1-50, 50-100, 100-250, 250-500, 500-1000, 1000-2500, 2500+
    puts 'attendance'
    @log += "\n" + "attendance: #{"???"}"
    select = driver.find_element(:id, 'attendance')
    options = select.find_elements(:tag_name, 'option')
    options.each do |option|
      if option.text == '1 - 50'
        option.click
      end
    end
    #category - dropdown
    puts 'category'
    @log += "\n" + "category: #{"???"}"
    select = driver.find_element(:id, 'category')
    options = select.find_elements(:tag_name, 'option')
    options.each do |option|
      if option.text == 'Business'
        option.click
      end
    end
    # <div class="select-wrapper"><select> "admission" -> price
    puts 'admission'
    admission = driver.find_elements(:tag_name, 'option')
    admission.each do |element|
      if (params[:price].present?)
        @log += "\n" + "admission: #{params[:price]}"
        if element.text == "Price"
          element.click
          # then the price element
          wait.until { driver.find_element(:css, 'input[ng-model="ctrl.type.value[0].price"]') }
          driver.find_element(:css, 'input[ng-model="ctrl.type.value[0].price"]').send_keys(params[:price], :tab)
          # then the price element
          wait.until { driver.find_element(:css, 'input[ng-model="ctrl.type.value[0].price"]') }
          driver.find_element(:css, 'input[ng-model="ctrl.type.value[0].price"]').send_keys(params[:price], :tab)

        end
      else
        if element.text == "Free"
          element.click
        end
      end
    end

    #button next
    puts 'next'
    buttons = driver.find_element(:tag_name, 'button')

    if buttons.text == "NEXT"
      buttons.click
    end

    sleep 2

    flash_message = driver.find_element(:tag_name, 'flash-messages')

    if ( flash_message.present? )
      puts "flash message"
      @log += driver.find_element(:tag_name, 'flash-messages').text
      @errors = driver.find_elements(:class, 'error')
      @error_items = ""
      @errors.each { |error|
          @error_items += error.text + ", "
      }
      @log = "Error present! " + @log + " " + @error_items
      sleep 2
      driver.quit
    else
      #page 2
      #media
      wait.until { driver.find_element(:class, 'media-links') }
      puts 'images'
      driver.find_element(:css, 'input[ng-model="imageUrl"]').send_keys(nul_check(params[:image_url]))

      #event contact
      puts 'event contact'
      driver.find_element(:css, 'input[ng-model="vm.form.formData.basicInfo.phone"]').send_keys('5551234567')
      #event email
      puts 'event email'
      driver.find_element(:css, 'input[ng-model="vm.form.formData.basicInfo.email"]').send_keys('example@example.com')

      #if personal != event
      driver.find_element(:css, 'label[ng-model="vm.sameContact').click

      #submitter phone
      puts 'submitter phone'
      #driver.find_element(:css, 'input[ng-model="vm.form.formData.submitter.phone"]').send_keys('5552345678')
      driver.find_element(:name, 'submitterPhone').send_keys('5552345678')
      #submitter email
      puts 'submitter email'
      driver.find_element(:css, 'input[ng-model="vm.form.formData.submitter.email"]').send_keys(:control, :backspace, 'example@example.com')
      #submitter name
      puts 'submitter name'
      driver.find_element(:css, 'input[ng-model="vm.form.formData.submitter.name"]').send_keys(nul_check(params[:author]))

      #don't send me news
      puts 'no news'
      driver.find_element(:css, 'label[ng-model="vm.form.formData.interests.newsletter"]').click

      #submit
      #driver.find_element(:css, 'button[type="submit"]').click


      begin
        wait.until { driver.find_element(:class => "title-header") }
        #acceptance page capture that we can send back to the user
        @log += driver.find_element(:class , 'sg-message').text
      rescue Selenium::WebDriver::Error::TimeOutError
        @log += "\n timeout error on submission"
        driver.quit
      end

      #quit the driver
      if (driver.find_element(:tag_name, 'flash-messages').displayed?)
        @log += driver.find_element(:tag_name, 'flash-messages').text
      end

      if (@log.present?)
        @errors = driver.find_elements(:class, 'error')
        @error_items = ""
        @errors.each { |error|
            @error_items += error.text + ", "
        }
        @log = "Error present! " + @log + " " + @error_items
        sleep 2
        headless.destroy
      else
        headless.destroy
        @log += "\n Complete, no errors!"
      end
    end

  end

end
