module ProductsHelper
 
  def render_product_photo(photo)
    if photo.present?
      image_tag(photo.image.thumb.url, :class => "thumbnail")
    else
      image_tag("http://placehold.it/200x200&text=No Pic", :class => "thumbnail")
    end
  end
    
end