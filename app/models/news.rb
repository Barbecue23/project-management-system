class News < ApplicationRecord
    has_one_attached :banner_image
    has_many_attached :more_images

    has_many :news_groups
    has_many :advisor_groups, through: :news_groups
end
