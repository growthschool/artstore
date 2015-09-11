module ProductsHelper
	def render_product_photo(photo, size = "thumb")
		if photo.present?
			image_url = photo.image.send(size).url

			#image_tag photo.image.thumb.url, class: "product_image"
			#image_tag photo.image.medium.url, class: "product_image"			
		else
			image_url = render_no_pic_url(size)
		end

		image_tag(image_url, class: "product_image")
	end

	private
		def render_no_pic_url(size)
			case size
			when :medium
				volume = "300x300"
			else
				volume = "200x200"
			end

			return "http://placehold.it/#{volume}&text=No Pic"
		end
end
