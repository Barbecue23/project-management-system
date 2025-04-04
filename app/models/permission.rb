class Permission < ApplicationRecord
    has_many :map_permissions, dependent: :destroy
    has_many :roles, through: :map_permissions

    attribute :default_view, :boolean, default: false
    attribute :default_edit, :boolean, default: false
    attribute :default_create, :boolean, default: false
    attribute :default_delete, :boolean, default: false
end
