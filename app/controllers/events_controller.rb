class EventsController < ApplicationController
	before_action :authenticate_user!
	respond_to :json
	def create
		e = current_user.events.build(
			uid: event_params[:id],
			start_time: event_params[:dstart],
			end_time: event_params[:dtend],
			description: event_params[:body_text],

			address: event_params[:address],
			city: event_params[:city],
			state: event_params[:state],
			country: event_params[:country],
			postal_code: event_params[:postal_code],
			timezone: event_params[:timezone],

			price: event_params[:price],

			url: event_params[:url],
			ticketing_url: event_params[:ticketing_url],
			fb_url: event_params[:fb_event_url],
			image_url: event_params[:image_url]
		)
		o = Organizer.find_or_create_by(name: event_params[:organization])
		v = Venue.find_or_create_by(name: event_params[:venue], address: event_params[:address],
			city: event_params[:city], state: event_params[:state], country: event_params[:country],
			postal_code: event_params[:postal_code])
		e.organizer = o
		e.venue = v
		if e.save
			render json: e, status: 201
		else
		    render json: { errors: e.errors }, status: 422
		end

	end


	private
	def event_params
		params.require(:json_event).permit(:id, :dstart, :dtend, :sequence, 
			:status, :r_freq, :body_text,
			:body, :editor, :fb_event_url, :r_rule, :location, 
			:duration, :geo, :city, :timezone, :invitation, :venue,
			:organization, :country, :price, :postal_code, :timezone, 
			:ticketing_url, :state, :url, :address, :author, :organization,
			:image_url, :ticketing_url, :categories => [])
	end
end
