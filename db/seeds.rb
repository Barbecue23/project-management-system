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

AdvisorGroup.create!([
  {
    group_name: "กลุ่มที่ 1",
    owner_id: 1,
    created_at: Time.zone.now,
    updated_at: Time.zone.now
  },
  {
    group_name: "กลุ่มที่ 2",
    owner_id: 2,
    created_at: Time.zone.now,
    updated_at: Time.zone.now
  },
  {
    group_name: "กลุ่มที่ 3",
    owner_id: 3,
    created_at: Time.zone.now,
    updated_at: Time.zone.now
  }
])

Role.create!([
  { name: "อาจารย์", created_by: "system", updated_by: "system", created_at: Time.zone.now, updated_at: Time.zone.now },
  { name: "นิสิต", created_by: "system", updated_by: "system", created_at: Time.zone.now, updated_at: Time.zone.now }
])

User.create!([
  {
    name: "อ.ดร. สัจจาภรณ์ ไวยญาณ",
    student_id: "N/A",
    email: "sajchaporn@silpakorn.edu",
    faculty: "วิทยาศาสตร์",
    major: "วิศวกรรมซอฟต์แวร์",
    role_id: Role.find_by(name: "อาจารย์").id,
    created_at: Time.zone.now,
    updated_at: Time.zone.now
  },
  {
    name: "นาย ก้องภพ อินทร์ทอง",
    student_id: "65303010001",
    email: "kongpop@student.su.ac.th",
    faculty: "วิทยาศาสตร์",
    major: "วิศวกรรมซอฟต์แวร์",
    role_id: Role.find_by(name: "นิสิต").id,
    created_at: Time.zone.now,
    updated_at: Time.zone.now
  },
  {
    name: "นางสาว ชญานิศา ศรีสุวรรณ",
    student_id: "65303010002",
    email: "chayanisa@student.su.ac.th",
    faculty: "วิทยาศาสตร์",
    major: "วิศวกรรมซอฟต์แวร์",
    role_id: Role.find_by(name: "นิสิต").id,
    created_at: Time.zone.now,
    updated_at: Time.zone.now
  }
])

AdvisorGroupMember.create!([
  {
    advisor_group_id: 1,
    user_id: User.find_by(email: "sajchaporn@silpakorn.edu")&.id, # อาจารย์
    is_owner: true,
    created_at: Time.zone.now,
    updated_at: Time.zone.now
  }
])
