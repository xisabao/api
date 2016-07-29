class Api::V1::ConciergeAllianceController < ApplicationController
	def create
		event_submit(params[:json_event])
	end
	def event_submit(params)
		browser = Watir::Browser.new
		browser.goto("http://www.conciergealliance.com/calendar-final/")

		browser.link(text: "Post Your Event").click

		browser.text_field(name: "post_title").when_present.set(params[:title])

		#TODO: js date selector

		browser.quit
	end

end
