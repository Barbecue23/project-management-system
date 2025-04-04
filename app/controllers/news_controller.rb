class NewsController < ApplicationController
  def index
    @news = [
      {
        title: "การขึ้นทะเบียนนักศึกษา",
        content: "SU-TCAS68 รอบ 1 แฟ้มสะสมผลงาน (Portfolio)",
        publish_date: "2 ชั่วโมงที่แล้ว",
        announcer: "ศิลปากร",
        banner_image: "news1.svg",
        category: "Education",
        more_images: []
      },
      {
        title: "งานทะเบียนและประมวลผล งดให้บริการ",
        content: "ปิดให้บริการชั่วคราวในวันที่ 13 - 14 กุมภาพันธ์ 2568",
        publish_date: "1 ชั่วโมงที่แล้ว",
        announcer: "ศิลปากร",
        banner_image: "news2.jpg",
        category: "Education",
        more_images: []
      },
      {
        title: "กำหนดการวันสุดท้ายของการถอนติด W",
        content: "ต้องดำเนินการก่อน 17 ตุลาคม 2568 เวลา 16.30 น.",
        publish_date: "1 ชั่วโมงที่แล้ว",
        announcer: "ศิลปากร",
        banner_image: "news3.png",
        category: "Education",
        more_images: []
      },
      {
        title: "กิจกรรมบริจาคโลหิต 2568",
        content: "ร่วมบริจาคโลหิตได้ที่ คณะ 016 มหาวิทยาลัยศิลปากร",
        publish_date: "1 ชั่วโมงที่แล้ว",
        announcer: "ศิลปากร",
        banner_image: "news4.svg",
        category: "Education",
        more_images: []
      },
      {
        title: "SU: Next Step รุ่น 1 ประจำปีการศึกษา 2568",
        content: "โครงการเรียนล่วงหน้าสำหรับนักศึกษาหลักสูตร (4+1)",
        publish_date: "1 ชั่วโมงที่แล้ว",
        announcer: "ศิลปากร",
        banner_image: "news5.jpg",
        category: "Education",
        more_images: []
      }
    ]
  end

  def new
    @news = News.new
  end

  def create
    is_public = params[:category] == "All"

    @news = News.new(news_params.merge(is_public: is_public, created_by: "system"))

    if @news.save
      unless is_public
        advisor_group_ids = AdvisorGroup.where(group_name: params[:category]).pluck(:id)
        advisor_group_ids.each do |advisor_group_id|
          NewsGroup.create!(news: @news, advisor_group_id: advisor_group_id, created_by: "system")
        end
      end
      redirect_to news_index_path
    else
      render :new
    end
  end

  private

  def news_params
    params.permit(:title, :content, :publish_date)
  end
end
