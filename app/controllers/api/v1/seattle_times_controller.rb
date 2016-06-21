class Api::V1::SeattleTimesController < ApplicationController
	def create
    	event_submit(params[:json_event])
    end
	def event_submit(params)
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
end
