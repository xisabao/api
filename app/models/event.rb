class Event < ActiveRecord::Base
	belongs_to :organizer
	belongs_to :venue
	belongs_to :user

	enum status: [:pending, :error, :success]
end
