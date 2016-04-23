class Api::V1::WineCountryController < ApplicationController
	def create
    	event_submit(params[:json_event])
    end
	def event_submit(params)
		browser = Watir::Browser.new
		browser.goto('http://www.winecountry.com/submit-event/')

		browser.text_field(name: "venue-name").set(params[:venue])
		browser.text_field(name: "event-title").set(params[:title])
		browser.text_field(name: "venue-phone").set(params[:contact_phone])
		browser.text_field(name: "event-url").set(params[:url])
		browser.text_area(name: "event-description").set(params[:body])

		browser.input(name: "date-start").send_keys(date_convert(params[:dtstart]))
		browser.input(name: "date-end").send_keys(date_convert(params[:dtend]))
		browser.input(name: "time-start").send_keys(time_convert(params[:dtstart]))
		browser.input(name: "time-end").send_keys(time_convert(params[:dtend]))

		browser.text_field(name: "event-cost").set(params[:price])
		browser.text_field(name: "event-address").set(params[:address])
		browser.select_list(name: "menu-region").select(params[:region])
		browser.text_field(name: "your-name").set(params[:first_name] + " " + params[:last_name])
		browser.text_field(name: "your-email").set(params[:email])

		# deal with captcha

		browser.quit
	end
end
