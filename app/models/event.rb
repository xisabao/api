class Event < ActiveRecord::Base
	belongs_to :organizer
	belongs_to :venue
end
