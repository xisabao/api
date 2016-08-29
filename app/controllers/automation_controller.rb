class AutomationController < ApplicationController

	respond_to :json

	def create
		visit_seattle(event_params) if event_params[:endpoints].include? "visit_seattle"
		visit_corvallis(event_params) if event_params[:endpoints].include? "visit_corvallis"
		seattle_times(event_params) if event_params[:endpoints].include? "seattle_times"
		pdx_monthly(event_params) if event_params[:endpoints].include? "pdx_monthly"
		bellevue_reporter(event_params) if event_params[:endpoints].include? "bellevue_reporter"
	end


	def visit_seattle(params)
		browser = Watir::Browser.new
		browser.goto("http://www.visitseattle.org/things-to-do/events/submit-your-event/")

		browser.text_field(id: "input_13_18_3").set(params[:first_name])
		browser.text_field(id: "input_13_18_6").set(params[:last_name])
		browser.text_field(id: "input_13_4").set(params[:email])

		browser.text_field(id: "input_13_1").set(params[:title])
		browser.text_field(id: "input_13_2").set(date_convert(params[:dtstart]))
		browser.text_field(id: "input_13_3").set(date_convert(params[:dtend]))

		browser.text_field(id: "input_13_5").set(params[:body])

		browser.text_field(id: "input_13_6").set(params[:contact_phone])
		browser.text_field(id: "input_13_7").set(params[:url])

		browser.text_field(id: "input_13_8").set(params[:venue])
		browser.text_field(id: "input_13_9_1").set(params[:address])
		browser.text_field(id: "input_13_10").set(params[:venue_phone])
		browser.text_field(id: "input_13_11").set(params[:venue_email])
		browser.text_field(id: "input_13_12").set(params[:venue_url])

		browser.text_field(id: "input_13_13").set(params[:organizer_name])
		browser.text_field(id: "input_13_14_1").set(params[:organizer_address])
		browser.text_field(id: "input_13_15").set(params[:organizer_phone])
		browser.text_field(id: "input_13_16").set(params[:organizer_email])
		browser.text_field(id: "input_13_17").set(params[:organizer_url])

		browser.button(value: "Submit").click

		browser.quit
	end

	def visit_corvallis(params)
		browser = Watir::Browser.new
		browser.goto("http://visitcorvallis.com/calendar-of-events/add-your-event/")		

		browser.text_field(id: "Field740").set(params[:title])
		browser.textarea(id: "Field741").set(params[:body])
		browser.text_field(id: "Field631").set(params[:street_address])
		browser.text_field(id: "Field633").set(params[:city])
		browser.text_field(id: "Field634").set(params[:state])
		browser.text_field(id: "Field635").set(params[:zip_code])
		browser.select_list(id: "Field636").select("United States")

		phone_arr = split_phone(params[:contact_phone])
		browser.text_field(id: "Field751").set(phone_arr[0])
		browser.text_field(id: "Field751-1").set(phone_arr[1])
		browser.text_field(id: "Field751-2").set(phone_arr[2])
		browser.text_field(id: "Field750").set(params[:url])
		browser.text_field(id: "Field749").set(params[:price])

		browser.text_field(id: "Field742-1").set(get_month(params[:dtstart]))
		browser.text_field(id: "Field742-2").set(get_day(params[:dtstart]))
		browser.text_field(id: "Field742").set(get_year(params[:dtstart]))
		browser.text_field(id: "Field744").set(get_hour(params[:dtstart]))
		browser.text_field(id: "Field744-1").set(get_minute(params[:dtstart]))
		browser.text_field(id: "Field744-2").set("00")

		browser.text_field(id: "Field743-1").set(get_month(params[:dtstart]))
		browser.text_field(id: "Field743-2").set(get_day(params[:dtstart]))
		browser.text_field(id: "Field743").set(get_year(params[:dtstart]))
		browser.text_field(id: "Field755").set(get_hour(params[:dtstart]))
		browser.text_field(id: "Field755-1").set(get_minute(params[:dtstart]))
		browser.text_field(id: "Field755-2").set("00")

		browser.text_field(id: "Field3").set(params[:first_name])
		browser.text_field(id: "Field4").set(params[:last_name])
		browser.text_field(id: "Field119").set(params[:email])
		phone_arr = split_phone(params[:contact_phone])
		browser.text_field(id: "Field13").set(phone_arr[0])
		browser.text_field(id: "Field13-1").set(phone_arr[1])
		browser.text_field(id: "Field13-2").set(phone_arr[2])

		browser.button(value: "Submit").click
		browser.quit
	end	

	def seattle_times(params)
		browser = Watir::Browser.new
		browser.goto('http://seattletimes.nwsource.com/cgi-bin/SubmitEvent.pl#_ga=1.71064728.905758907.1442507510')

		browser.select_list(name:"event_category").select(params[:category])
		browser.text_field(name: "event_name").set(params[:title])
		browser.text_area(name: "description").set(params[:body])
		browser.text_field(name: "event_url").set(params[:url])

		browser.text_field(name: "contact_name").set(params[:first_name] + " " + params[:last_name])
		browser.text_field(name: "contact_phone").set(params[:contact_phone])
		browser.text_field(name: "contact_email").set(params[:email])

		browser.text_field(name: "start_date").set(date_convert(params[:dtstart]))
		browser.text_field(name: "end_date").set(date_convert(params[	:dtend]))

		browser.text_field(name: "start_time").set(get_hour(params[:dtstart]) + ":" + get_minute(params[:dtstart]))
		browser.radio(value: get_meridian(params[:dtstart])).set
		
		if params[:price].to_i == 0
			browser.radio(value: "free").set 
		else
			browser.radio(value: "price_fixed").set
			browser.text_field(name: "price_fixed").set(params[:price])
		end

		browser.text_field(name: "ticket_url").set(params[:ticketing_url])
		browser.text_field(name: "venue_name").set(params[:venue])
		browser.text_field(name: "venue_phone").set(params[:venue_phone])
		browser.text_field(name: "venue_address").set(params[:street_address])
		browser.text_field(name: "venue_city").set(params[:city])
		browser.select_list(name: "venue_state").set(params[:state])
		browser.text_field(name: "venue_zip").set(params[:zip_code])
		browser.text_field(name: "venue_url").set(params[:venue_url])

		browser.text_field(name: "submitter_name").set(params[:first_name] + " " + params[:last_name])
		browser.text_field(name: "submitter_phone").set(params[:contact_phone])
		browser.text_field(name: "submitter_email").set(params[:email])

		browser.button(value: "Submit").click

		browser.quit
	end

	def pdx_monthly(params)
		browser = Watir::Browser.new
		browser.goto("http://www.pdxmonthly.com/pages/suggest-event/")

		browser.select_list(id: "Field1").select(params[:category])
		browser.text_field(id: "Field441").set(params[:title])
		browser.text_field(id: "Field549").set(params[:url])
		browser.textarea(id: "Field4").set(params[:body])	
		browser.text_field(id: "Field12-1").set(get_month(params[:dtstart]))
		browser.text_field(id: "Field12-2").set(get_day(params[:dtstart]))
		browser.text_field(id: "Field12").set(get_year(params[:dtstart]))
		browser.text_field(id: "Field114").set(get_hour(params[:dtstart]))
		browser.text_field(id: "Field114-1").set(get_minute(params[:dtstart]))
		browser.text_field(id: "Field114-2").set("00")

		browser.checkbox(id: "Field448").set if params[:price].to_i <= 10
		browser.checkbox(id: "Field449").set if params[:price].to_i <= 20
		browser.checkbox(id: "Field450").set if params[:all_ages] == "true"
		browser.checkbox(id: "Field451").set if params[:family_friendly] == "true"
		if params[:price].to_i == 0
			browser.radio(id: "Field335_0").set
		else
			browser.radio(id: "Field335_1").set
		end
		browser.text_field(id: "Field550").set(params[:ticketing_url])
		browser.text_field(id: "Field118").set(params[:venue])
		browser.text_field(id: "Field552").set(params[:venue_url])
		browser.text_field(id: "Field119").set(params[:street_address])
		browser.text_field(id: "Field121").set(params[:city])
		browser.text_field(id: "Field122").set(params[:state])
		browser.text_field(id: "Field123").set(params[:zip_code])
		browser.select_list(id: "Field124").set("United States")
		browser.text_field(id: "Field337").set(params[:organizer_name])

		browser.text_field(id: "Field6").set(params[:first_name])
		browser.text_field(id: "Field7").set(params[:last_name])
		phone_arr = split_phone(params[:contact_phone])
		browser.text_field(id: "Field8").set(phone_arr[0])
		browser.text_field(id: "Field8-1").set(phone_arr[1])
		browser.text_field(id: "Field8-2").set(phone_arr[2])
		browser.text_field(id: "Field10").set(params[:email])

		browser.radio(id: "Field554_1").set

		browser.button(value: "Submit").click

		browser.quit
	end

	def bellevue_reporter(params)
		browser = Watir::Browser.new
		browser.goto('http://www.bellevuereporter.com/calendar/submit/')

		browser.text_field(name: "eaa$TextboxName").wait_until_present
		browser.text_field(name: "eaa$TextboxName").set(params[:first_name] + " " + params[:last_name])
		browser.text_field(name: "eaa$TextboxEmail").set(params[:email])
		browser.text_field(name: "eaa$TextboxPhone").set(params[:contact_phone])

		browser.text_field(name: "eaa$custom3_0").set(params[:title])
		browser.textarea(name: "eaa$TextboxLocation").set(params[:address])

		
		browser.select_list(name: "eaa$DropDownStartMonth").select(get_full_month_name(params[:dtstart]))
		browser.select_list(name: "eaa$DropDownStartDay").select(get_day(params[:dtstart]))
		browser.select_list(name: "eaa$DropDownStartYear").select(get_year(params[:dtstart]))

		browser.link(text: "Specify End").click
		browser.select_list(name: "eaa$DropDownEndMonth").wait_until_present

		browser.select_list(name: "eaa$DropDownEndMonth").select(get_full_month_name(params[:dtend]))
		browser.select_list(name: "eaa$DropDownEndDay").select(get_day(params[:dtend]))
		browser.select_list(name: "eaa$DropDownEndYear").select(get_year(params[:dtend]))

		if params[:all_day] == "true"
			browser.checkbox(name: "eaa$CheckboxAllDay").set
		else
			browser.select_list(name: "eaa$DropDownStartHour").select(get_hour(params[:dtstart]))
			browser.select_list(name: "eaa$DropDownStartMinute").select(get_minute(params[:dtstart]))
			browser.select_list(name: "eaa$DropDownStartAMPM").select(get_meridian(params[:dtstart]).upcase)

			browser.select_list(name: "eaa$DropDownEndHour").select(get_hour(params[:dtend]))
			browser.select_list(name: "eaa$DropDownEndMinute").select(get_minute(params[:dtend]))
			browser.select_list(name: "eaa$DropDownEndAMPM").select(get_meridian(params[:dtend]).upcase)
		end
		browser.checkbox(id: get_category(params[:category])).set

		browser.text_field(name: "eaa$custom6_0").set(params[:url])
		browser.textarea(name: "eaa$custom4_0").set(params[:body])

		browser.button(name: "eaa$ButtonSubmit").click

		browser.button(name: "eaa$btnSubmitIt").when_present.click

		browser.quit
	end


	private
	def event_params
		params.require(:json_event).permit(:first_name, :last_name, :email, :contact_phone, :category, :title,
			:venue, :url, :ticketing_url, :body, :dtstart, :dtend, :price, :address, :street_address, :city, :state,
			:zip_code, :region, :venue_phone, :venue_email, :venue_url, :organizer_name, :organizer_address, :organizer_email,
			:organizer_phone, :organizer_url, :all_ages, :family_friendly, :all_day, endpoints: [])
	end
end
