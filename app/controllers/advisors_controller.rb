# app/controllers/advisors_controller.rb
class AdvisorsController < ApplicationController
  def index
    @advisors = [
      {
        id: 1,
        name: "อ.ดร.สัจจาภรณ์ ไวยญาณ",
        position: "Dr.Saijaporn Waijanya",
        specialty: "Software Engineer",
        specialty_details: "ดูเพิ่มเติม",
        email: "waijanya_s@silpakorn.edu",
        alternate_email: "saijaporn.w@gmail.com",
        current_students: 4,
        max_students: 6,
        status: "active"
      },
      {
        id: 2,
        name: "อ.ดร.สัจจาภรณ์ ไวยญาณ",
        position: "Dr.Saijaporn Waijanya",
        specialty: "Software Engineer",
        specialty_details: "ดูเพิ่มเติม",
        email: "waijanya_s@silpakorn.edu",
        alternate_email: nil,
        current_students: 6,
        max_students: 6,
        status: "active"
      },
      {
        id: 3,
        name: "อ.ดร.สัจจาภรณ์ ไวยญาณ",
        position: "Dr.Saijaporn Waijanya",
        specialty: "Software Engineer",
        specialty_details: "ดูเพิ่มเติม",
        email: "waijanya_s@silpakorn.edu",
        alternate_email: "saijaporn.w@gmail.com",
        current_students: 4,
        max_students: 6,
        status: "active"
      },
      {
        id: 4,
        name: "อ.ดร.สัจจาภรณ์ ไวยญาณ",
        position: "Dr.Saijaporn Waijanya",
        specialty: "Software Engineer",
        specialty_details: "ดูเพิ่มเติม",
        email: "waijanya_s@silpakorn.edu",
        alternate_email: "saijaporn.w@gmail.com",
        current_students: 6,
        max_students: 10,
        status: "active"
      },
      {
        id: 5,
        name: "อ.ดร.สัจจาภรณ์ ไวยญาณ",
        position: "Dr.Saijaporn Waijanya",
        specialty: "Software Engineer",
        specialty_details: "ดูเพิ่มเติม",
        email: "waijanya_s@silpakorn.edu",
        alternate_email: "saijaporn.w@gmail.com",
        current_students: 7,
        max_students: 10,
        status: "active"
      },
      {
        id: 6,
        name: "อ.ดร.สัจจาภรณ์ ไวยญาณ",
        position: "Dr.Saijaporn Waijanya",
        specialty: "Software Engineer",
        specialty_details: "ดูเพิ่มเติม",
        email: "waijanya_s@silpakorn.edu",
        alternate_email: nil,
        current_students: 3,
        max_students: 6,
        status: "active"
      }
    ]
  end
end
