# app/mailers/student_mailer.rb
class StudentMailer < ApplicationMailer
    default from: "tunzax014@gmail.com"
    def rejection_email(student, advisor)
        @student = student
        @advisor = advisor
        mail(to: [ @student.email, @advisor.email ], subject: "เข้าร่วมกลุ่มที่อาจารย์ที่ปรึกษาถูกยกเลิก")
      end
end
