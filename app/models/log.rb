class Log < ActiveRecord::Base
	has_one :event
	belongs_to :user
end
