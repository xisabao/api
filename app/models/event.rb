class Event < ActiveRecord::Base
	belongs_to :organizer
	belongs_to :venue
	has_many :events, through: :logs
	has_many :logs, dependent: :destroy
end
