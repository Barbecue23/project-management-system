module NewsHelper
    def news_image_path(image)
        if image.present? && File.exist?(Rails.root.join("app/assets/images", image))
          asset_path(image) # ✅ Use `asset_path` to ensure the correct path
        else
            nil
        end
      end

  # def news_image_path(image)
  #     if image.present? # If image is stored in the database
  #       image # Directly return the image URL
  #     elsif Rails.public_path.join("assets", image).exist?
  #       asset_path(image) # Use local asset
  #     else
  #       asset_path("placeholder.png") # Use placeholder if nothing is found
  #     end
  #   end
end
