module ApplicationHelper
	# Returns the full title on a per-page basis.
	def full_title (page_title = '')
		base_title = "Beautiful Girl App"
		if page_title.empty? # kiem tra page_title ma trong
			base_title
		else
			page_title + " | " +base_title
		end
	end
	def form_image_select(micropost)  
	  return image_tag micropost.picture.url(:medium),
	                   id: 'image-preview',
	                   class: 'img-responsive' if micropost.picture.exists?
	  image_tag 'placeholder.jpg', id: 'image-preview', class: 'img-responsive'
	end
end
