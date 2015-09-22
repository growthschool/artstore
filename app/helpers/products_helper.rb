module ProductsHelper
  def render_product_photo(photo, size ="thumb")
    if photo.present?
      # image_tag(photo.image.thumb.url, class: "thumbnail")
      image_url = photo.image.send(size).url
    else
      # image_tag("http://placehold.it/200x200&text=No pic", class: "thumbnail")
      image_url = render_no_pic_url(size)

    end
    image_tag(image_url, class: "thumbnail")
  end
  private

  def render_no_pic_url(size)
    case size
    when :medium
      volume = "300x300"
    else
      volume = "200x200"
    end
      return "http://placehold.it/#{volume}&text=No pic"
    # return "http://placehold.it/300x300&text=No pic"
  end
  def render_cart_items_count(cart)
      cart.cart_items.count
  end

end
