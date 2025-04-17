# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# db/seeds.rb

Permission.create!([
  { name: "news", default_view: true, default_create: true, default_edit: true, default_delete: true, created_at: Time.zone.now, updated_at: Time.zone.now },
  { name: "advisor_group", default_view: true, default_create: true, default_edit: true, default_delete: true, created_at: Time.zone.now, updated_at: Time.zone.now },
  { name: "seasons", default_view: true, default_create: true, default_edit: true, default_delete: true, created_at: Time.zone.now, updated_at: Time.zone.now }
])

Role.create!([
  { name: "ผู้ดูแลระบบ", created_by: "system", updated_by: "system", created_at: Time.zone.now, updated_at: Time.zone.now },
  { name: "อาจารย์", created_by: "system", updated_by: "system", created_at: Time.zone.now, updated_at: Time.zone.now },
  { name: "ผู้ประสารงาน", created_by: "system", updated_by: "system", created_at: Time.zone.now, updated_at: Time.zone.now },
  { name: "นักศึกษา", created_by: "system", updated_by: "system", created_at: Time.zone.now, updated_at: Time.zone.now }
])

MapPermission.create!([
  { role_id: Role.find_by(name: "ผู้ดูแลระบบ").id, permission_id: Permission.find_by(name: "news").id, can_view: true, can_create: true, can_edit: true, can_delete: true, created_by: "system", updated_by: "system", created_at: Time.zone.now, updated_at: Time.zone.now },
  { role_id: Role.find_by(name: "ผู้ดูแลระบบ").id, permission_id: Permission.find_by(name: "advisor_group").id, can_view: true, can_create: true, can_edit: true, can_delete: true, created_by: "system", updated_by: "system", created_at: Time.zone.now, updated_at: Time.zone.now },
  { role_id: Role.find_by(name: "ผู้ดูแลระบบ").id, permission_id: Permission.find_by(name: "seasons").id, can_view: true, can_create: true, can_edit: true, can_delete: true, created_by: "system", updated_by: "system", created_at: Time.zone.now, updated_at: Time.zone.now },
  { role_id: Role.find_by(name: "อาจารย์").id, permission_id: Permission.find_by(name: "news").id, can_view: true, can_create: true, can_edit: true, can_delete: true, created_by: "system", updated_by: "system", created_at: Time.zone.now, updated_at: Time.zone.now },
  { role_id: Role.find_by(name: "อาจารย์").id, permission_id: Permission.find_by(name: "advisor_group").id, can_view: true, can_create: false, can_edit: false, can_delete: false, created_by: "system", updated_by: "system", created_at: Time.zone.now, updated_at: Time.zone.now },
  { role_id: Role.find_by(name: "ผู้ประสารงาน").id, permission_id: Permission.find_by(name: "news").id, can_view: true, can_create: true, can_edit: true, can_delete: true, created_by: "system", updated_by: "system", created_at: Time.zone.now, updated_at: Time.zone.now },
  { role_id: Role.find_by(name: "ผู้ประสารงาน").id, permission_id: Permission.find_by(name: "advisor_group").id, can_view: true, can_create: true, can_edit: true, can_delete: true, created_by: "system", updated_by: "system", created_at: Time.zone.now, updated_at: Time.zone.now },
  { role_id: Role.find_by(name: "ผู้ประสารงาน").id, permission_id: Permission.find_by(name: "seasons").id, can_view: true, can_create: true, can_edit: true, can_delete: true, created_by: "system", updated_by: "system", created_at: Time.zone.now, updated_at: Time.zone.now },
  { role_id: Role.find_by(name: "นักศึกษา").id, permission_id: Permission.find_by(name: "news").id, can_view: true, can_create: false, can_edit: false, can_delete: false, created_by: "system", updated_by: "system", created_at: Time.zone.now, updated_at: Time.zone.now }
])
