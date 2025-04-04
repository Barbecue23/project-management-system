class Role < ApplicationRecord
    has_many :users
    has_many :map_permissions, dependent: :destroy
    has_many :permissions, through: :map_permissions
end
