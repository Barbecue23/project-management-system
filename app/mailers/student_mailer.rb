# app/mailers/student_mailer.rb
class StudentMailer < ApplicationMailer
    default from: "tunzax014@gmail.com"
    def rejection_email(student, advisor)
        @student = student
        @advisor = advisor
        mail(to: [ @student.email, @advisor.email ], subject: "คำร้องขออาจารย์ที่ปรึกษาถูกปฏิเสธ")
      end
end
