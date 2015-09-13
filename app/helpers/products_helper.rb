module ProductsHelper
  def render_product_photo(photo, size = "thumb")
    if photo.present?
      image_url = photo.image.send(size).url
    else
      image_url = render_no_pic_url(size)
    end

    image_tag(image_url, class: "thumbnail")
  end

  private

  def render_no_pic_url(size)
    case size
    when :medium
      volumn = "400x400"
    else
      volumn = "200x200"
    end

    return "http://placehold.it/#{volumn}&text=No Pic"
  end
end
