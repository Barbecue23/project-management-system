class NewsController < ApplicationController
    def index
      @news = [
        {
          title: "การขึ้นทะเบียนนักศึกษา",
          info: "SU-TCAS68 รอบ 1 แฟ้มสะสมผลงาน (Portfolio)",
          createAt: "2 ชั่วโมงที่แล้ว",
          createBy: "ศิลปากร",
          image: "news1.svg"
        },
        {
          title: "งานทะเบียนและประมวลผล งดให้บริการ",
          info: "ปิดให้บริการชั่วคราวในวันที่ 13 - 14 กุมภาพันธ์ 2568",
          createAt: "1 ชั่วโมงที่แล้ว",
          createBy: "ศิลปากร",
          image: "news2.jpg"
        },
        {
          title: "กำหนดการวันสุดท้ายของการถอนติด W",
          info: "ต้องดำเนินการก่อน 17 ตุลาคม 2568 เวลา 16.30 น.",
          createAt: "1 ชั่วโมงที่แล้ว",
          createBy: "ศิลปากร",
          image: "news3.png"
        },
        {
          title: "กิจกรรมบริจาคโลหิต 2568",
          info: "ร่วมบริจาคโลหิตได้ที่ คณะ 016 มหาวิทยาลัยศิลปากร",
          createAt: "1 ชั่วโมงที่แล้ว",
          createBy: "ศิลปากร",
          image: "news4.svg"
        },
        {
          title: "SU: Next Step รุ่น 1 ประจำปีการศึกษา 2568",
          info: "โครงการเรียนล่วงหน้าสำหรับนักศึกษาหลักสูตร (4+1)",
          createAt: "1 ชั่วโมงที่แล้ว",
          createBy: "ศิลปากร",
          image: "news5.jpg"
        }
      ]
    end
  end
  