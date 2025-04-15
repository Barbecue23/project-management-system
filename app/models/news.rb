class News < ApplicationRecord
    has_one_attached :banner_image
    has_many_attached :more_images
end
