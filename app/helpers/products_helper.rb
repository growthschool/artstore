module ProductsHelper
  def render_product_image(image, size = 'small')
    image_url = image.nil? ? no_pic_url(size) : image.send(size).url
    image_tag(image_url, class: 'thumbnail')
  end

  private

  def no_pic_url(size)
    volume = case size
    when 'small'
      '200x200'
    when 'medium'
      '400x400'
    when 'large'
      '800x800'
    end

    'http://placehold.it/' + volume + '&text=No Photo'
  end
end
