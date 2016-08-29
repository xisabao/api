class Api::V1::SeattlePiController < ApplicationController
	def create
    	event_submit(params[:json_event])
    end
	def event_submit(params)
		browser = Watir::Browser.new
		browser.goto("https://www.spingo.com/submit/?partnerId=2033")

		browser.text_field(id: "title").set(params[:title])
		browser.div(class: "toggle-create-venue").click
		browser.text_field(id: "venueTitle").set(params[:venue])
		browser.text_field(name: "venueStreet").set(params[:street_address])
		browser.text_field(name: "venueCity").set(params[:city])
		browser.text_field(name: "venueState").set(params[:state])
		browser.text_field(name: "venuePostalCode").set(params[:zip_code])

		#deal with js date selector

	end
end
