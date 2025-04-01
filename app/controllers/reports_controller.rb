class ReportsController < ApplicationController
  def index
    reports = [
      { name: "CS-1111-Kiw.jpg", uploader: "สัจาภรณ์ โวรรยา", date: "12/02/2568" },
      { name: "CS-1112-Kiw.jpg", uploader: "สัจาภรณ์ โวรรยา", date: "12/02/2568" },
      { name: "CS-1113-Kiw.pdf", uploader: "สัจาภรณ์ โวรรยา", date: "12/02/2568" },
      { name: "CS-1114.mp4", uploader: "สัจาภรณ์ โวรรยา", date: "12/02/2568" },
      { name: "CS-kiwkiw.docx", uploader: "สัจาภรณ์ โวรรยา", date: "12/02/2568" },
      { name: "CS-test.docx", uploader: "สัจาภรณ์ โวรรยา", date: "12/02/2568" }
    ]
    @reports = Kaminari.paginate_array(reports).page(params[:page]).per(5)

    @projects = Kaminari.paginate_array([
      { title: "ระบบจัดการนักศึกษา", student_name: "น.ส.ปรียา", year: "2566", category: "Web App" },
      { title: "ระบบสแกนใบหน้า", student_name: "นายเจษ", year: "2565", category: "AI" },
      { title: "ระบบคลังเอกสาร", student_name: "นายวีรชัย", year: "2567", category: "ระบบสารสนเทศ" }
    ]).page(params[:page]).per(5)
  end
end
