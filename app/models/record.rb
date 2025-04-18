class Record < ApplicationRecord
  has_one_attached :file

  enum record_type: { report: "รายงาน", project: "โครงการที่ผ่านมา" }

  validate :file_must_be_attached
  validates :record_type, presence: true

  def file_must_be_attached
    errors.add(:file, "ต้องแนบไฟล์") unless file.attached?
  end
end
