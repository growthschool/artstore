module ProductsHelper
	def render_product_photo(photo, size = "thumb")
		if photo.present?
			image_url = photo.image.send(size).url
		else
			image_url = no_picture_url(size)
		end

		image_tag(image_url, class: "img-thumbnail")
	end

	def no_picture_url(size)
		case size
		when :medium
			volumn = "300x300"
		else
			volumn = "200x200"
		end

		return "http://placehold.it/#{volumn}&text=No Picture"
	end
end
