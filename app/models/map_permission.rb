class MapPermission < ApplicationRecord
  belongs_to :role
  belongs_to :permission

  validates :role_id, uniqueness: { scope: :permission_id, message: "already has this permission assigned" }

  attribute :can_view, :boolean, default: false
  attribute :can_edit, :boolean, default: false
  attribute :can_create, :boolean, default: false
  attribute :can_delete, :boolean, default: false
end
