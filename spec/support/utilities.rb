	# Returns the full title for static_pages_spec
	def full_title(page_title)
		base_title = "ROR Tut. Samp. App"
		if page_title.empty?
			base_title
		else
			"#{base_title} | #{page_title}"
		end		
	end
