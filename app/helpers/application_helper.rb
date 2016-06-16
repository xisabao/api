module ApplicationHelper
	def date_convert(t)
		time = Time.parse(t)
		return time.strftime("%m/%d/%Y")
	end
	def time_convert(t)
		time = Time.parse(t)
		return time.strftime("%I:%M%p")
	end

	def get_meridian(t) 
		time = Time.parse(t)
		return time.strftime("%P")
	end
	def get_month(t)
		time =Time.parse(t)
		return time.strftime("%m")
	end
	def get_day(t)
		time = Time.parse(t)
		return time.strftime("%d")
	end
	def get_year(t)
		time = Time.parse(t)
		return time.strftime("%Y")
	end
	def get_hour(t)
		time = Time.parse(t)
		return time.strftime("%I")
	end
	def get_minute(t)
		time = Time.parse(t)
		return time.strftime("%M")
	end
	def split_phone(phone)
		return [phone[0..2], phone[3..5], phone[6..9]]
	end
end
