module ProductsHelper
    def render_product_photo(photo, size = "thumb")
        if photo.present?
            image_url = photo.image.send(size).url
        else
            image_url = default
        end
        image_tag(image_url, class: "thumbnail")
    end

    private

    def default
        return "http://placehold.it/200x200&text=No Pic"
    end
end
