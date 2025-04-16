class Season < ApplicationRecord
    def season_range_text
        return "ไม่มีข้อมูลฤดูกาล" unless seasons_detail.present? && seasons_detail.is_a?(Array)

        # แปลง Array of Hash → Hash แบบรวมทั้งหมด
        flat_hash = seasons_detail.reduce({}, :merge)

        # เรียง key ตามลำดับ
        sorted = flat_hash.sort_by { |key, _| key.to_i }

        first_detail = sorted.first&.last
        last_detail  = sorted.last&.last

        if first_detail && last_detail
          "#{first_detail['year']}/#{first_detail['term']} - #{last_detail['year']}/#{last_detail['term']}"
        else
          "ไม่มีข้อมูลฤดูกาล"
        end
      end
end
