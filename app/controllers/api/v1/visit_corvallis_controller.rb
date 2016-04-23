class Api::V1::VisitCorvallisController < ApplicationController
	def create
    	event_submit(params[:json_event])
    end
	def event_submit(params)
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
end
