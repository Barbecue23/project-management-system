class ReportsController < ApplicationController
  def index
    @reports = [
      { name: "CS-1111-Kiw.jpg", uploader: "สัจาภรณ์ โวรรยา", date: "12/02/2568" },
      { name: "CS-1112-Kiw.jpg", uploader: "สัจาภรณ์ โวรรยา", date: "12/02/2568" },
      { name: "CS-1113-Kiw.pdf", uploader: "สัจาภรณ์ โวรรยา", date: "12/02/2568" },
      { name: "CS-1114.mp4", uploader: "สัจาภรณ์ โวรรยา", date: "12/02/2568" },
      { name: "CS-kiwkiw.docx", uploader: "สัจาภรณ์ โวรรยา", date: "12/02/2568" }
    ]
  end
end
