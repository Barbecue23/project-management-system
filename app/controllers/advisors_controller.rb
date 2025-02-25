class AdvisorsController < ApplicationController
  def index
    advisors = [
      { id: 1, name: "อ.ดร.สัจจาภรณ์ ไวยญาณ", position: "Dr.Saijaporn Waijanya", specialty: "Software Engineer", specialty_details: "ดูเพิ่มเติม", email: "waijanya_s@silpakorn.edu", alternate_email: "saijaporn.w@gmail.com", current_students: 4, max_students: 6, status: "active" },
      { id: 2, name: "อ.ดร.สัจจาภรณ์ ไวยญาณ", position: "Dr.Saijaporn Waijanya", specialty: "Software Engineer", specialty_details: "ดูเพิ่มเติม", email: "waijanya_s@silpakorn.edu", alternate_email: nil, current_students: 6, max_students: 6, status: "active" },
      { id: 3, name: "อ.ดร.สัจจาภรณ์ ไวยญาณ", position: "Dr.Saijaporn Waijanya", specialty: "Software Engineer", specialty_details: "ดูเพิ่มเติม", email: "waijanya_s@silpakorn.edu", alternate_email: "saijaporn.w@gmail.com", current_students: 4, max_students: 6, status: "active" },
      { id: 4, name: "อ.ดร.สัจจาภรณ์ ไวยญาณ", position: "Dr.Saijaporn Waijanya", specialty: "Software Engineer", specialty_details: "ดูเพิ่มเติม", email: "waijanya_s@silpakorn.edu", alternate_email: "saijaporn.w@gmail.com", current_students: 6, max_students: 10, status: "active" },
      { id: 5, name: "อ.ดร.สัจจาภรณ์ ไวยญาณ", position: "Dr.Saijaporn Waijanya", specialty: "Software Engineer", specialty_details: "ดูเพิ่มเติม", email: "waijanya_s@silpakorn.edu", alternate_email: "saijaporn.w@gmail.com", current_students: 7, max_students: 10, status: "active" },
      { id: 6, name: "อ.ดร.สัจจาภรณ์ ไวยญาณ", position: "Dr.Saijaporn Waijanya", specialty: "Software Engineer", specialty_details: "ดูเพิ่มเติม", email: "waijanya_s@silpakorn.edu", alternate_email: nil, current_students: 3, max_students: 6, status: "active" },
      { id: 7, name: "อ.ดร.สมชาย สุทธิกุล", position: "Dr.Somchai Suthikul", specialty: "Data Scientist", specialty_details: "วิทยาการข้อมูล", email: "somchai.s@silpakorn.edu", alternate_email: "somchai.suthikul@gmail.com", current_students: 8, max_students: 10, status: "inactive" },
      { id: 8, name: "อ.ดร.ณัฐณิชา สมใจ", position: "Dr.Nattanicha Somjai", specialty: "UI/UX Designer", specialty_details: "ออกแบบประสบการณ์ผู้ใช้", email: "nattanicha.somjai@silpakorn.edu", alternate_email: "nattanicha.design@gmail.com", current_students: 2, max_students: 5, status: "active" },
      { id: 9, name: "อ.ดร.ไกรสร พานิช", position: "Dr.Kraisorn Panit", specialty: "Cybersecurity", specialty_details: "ความปลอดภัยไซเบอร์", email: "kraisorn.panit@silpakorn.edu", alternate_email: "kraisorn.panit@gmail.com", current_students: 5, max_students: 8, status: "active" },
      { id: 10, name: "อ.ดร.ชินาวรรธน์ กิจบรรจง", position: "Dr.Chinawat Kijbanjong", specialty: "Cloud Computing", specialty_details: "คอมพิวเตอร์คลาวด์", email: "chinawat.k@silpakorn.edu", alternate_email: nil, current_students: 9, max_students: 10, status: "active" }
    ]

    @advisors = Kaminari.paginate_array(advisors).page(params[:page]).per(5) # Paginate 4 per page
  end
end
