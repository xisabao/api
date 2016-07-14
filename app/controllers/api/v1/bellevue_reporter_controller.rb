class Api::V1::BellevueReporterController < ApplicationController
	def create
    	event_submit(params[:json_event])
    end
	def event_submit(params)
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
	def get_category(param_category)
		if param_category == "Art"
			return "eaa_custom25674_0_selectList_0"
		end
	end
end
