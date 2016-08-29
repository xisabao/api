class Api::V1::VisitSeattleController < ApplicationController
	def create
    	event_submit(params[:json_event])
    end
	def event_submit(params)
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
end
