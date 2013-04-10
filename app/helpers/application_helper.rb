module ApplicationHelper

	def format_datetime(date_time,style)
		date_time.strftime(style) if date_time
	  end
  
end
