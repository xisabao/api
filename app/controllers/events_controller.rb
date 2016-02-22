class EventsController < ApplicationController
	before_action :authenticate_user!
	respond_to :json
	def create
		
		#event create
		#organizer find or create by
		#venue find or create by

	end

	private
	def event_params
		params.require(:json_event).permit(:id, :dstart, :dtend, :sequence, :status, :r_freq, :body_text,
			:body, :editor, :fb_event_url, :r_rule, :location, :duration, :geo, :city, :timezone, :invitation, :venue,
			:organization, :country, :price, :postal_code, :timezone, :ticketing_url, :state, :url, :address, :author, :organization,
			:image_url, :ticketing_url, :categories => [])
	end
end
