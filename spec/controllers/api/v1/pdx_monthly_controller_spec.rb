require 'rails_helper'

RSpec.describe Api::V1::PdxMonthlyController, type: :controller do
	def create
    	event_submit(params[:json_event])
    end

	def event_submit(params)
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
	end
end
