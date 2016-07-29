class Api::V1::GreatNorthwestWineController < ApplicationController
	def create
		event_submit(params[:json_event])
	end
	def event_submit(params)
		browser = Watir::Browser.new
		browser.goto("http://www.greatnorthwestwine.com/events/community/add/")

		browser.text_field(name: "post_title").set(params[:title])
		browser.button(id: "tcepostcontent-html").click
		browser.textarea(name: "tcepostcontent").set(params[:body])

		if params[:all_day] == "true"
			browser.checkbox(name: "EventAllDay").set
		else
			browser.select_list(name: "EventStartHour").select(get_hour(params[:dtstart]))
			browser.select_list(name: "EventStartMinute").select(get_minute(params[:dtstart]))
			browser.select_list(name: "EventStartMeridian").select(get_meridian(params[:dtstart]))

			browser.select_list(name: "EventEndHour").select(get_hour(params[:dtend]))
			browser.select_list(name: "EventEndMinute").select(get_minute(params[:dtend]))
			browser.select_list(name: "EventEndMeridian").select(get_meridian(params[:dtend]))
		end
		browser.text_field(name: "EventStartDate").set(get_year(params[:dtstart]) + "-" 
			+ get_month(params[:dtstart]) + "-" + get_day(params[:dtstart]))
		browser.text_field(name: "EventEndDate").set(get_year(params[:dtend]) + "-" 
			+ get_month(params[:dtend]) + "-" + get_day(params[:dtend]))

		browser.text_field(id: "VenueVenue").set(params[:venue])
		browser.text_field(id: "VenueAddress").set(params[:street_address])
		browser.text_field(id: "VenueCity").set(params[:city])
		browser.li(text: "United States", class: "active-result").click
		browser.li(text: params[:state], class: "active-result").click
		browser.text_field(id: "EventZip").set(params[:zip_code])
		browser.text_field(id: "EventPhone").set(params[:venue_phone])
		browser.text_field(id: "EventWebsite").set(params[:venue_url])

		browser.text_field(name: "organizer[Organizer][]").set(params[:organizer_name])
		browser.text_field(name: "organizer[Phone][]").set(params[:organizer_phone])
		browser.text_field(name: "organizer[Website][]").set(params[:organizer_url])
		browser.text_field(name: "organizer[Email][]").set(params[:organizer_email])

		browser.text_field(id: "EventURL").set(params[:url])

		browser.text_field(id: "EventCost").set(params[:price])

		#CAPTCHA

		browser.button(value: "Submit").click
	end
end
