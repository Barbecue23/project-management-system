class NewsController < ApplicationController
  def index
    @news = News.includes(:banner_image_attachment).order(publish_date: :desc)
  end

  def show
    @news = News.find(params[:id])
  end


  def new
    @news = News.new
  end

  def create
    is_public = params[:category] == "All"

    @news = News.new(news_params.merge(is_public: is_public, created_by: current_user.name))

    if @news.save

      @news.banner_image.attach(params[:banner_image]) if params[:banner_image]

      if params[:more_images]
        params[:more_images].each do |img|
          @news.more_images.attach(img)
        end
      end

      unless is_public
        advisor_group_ids = AdvisorGroup.where(group_name: params[:category]).pluck(:id)
        advisor_group_ids.each do |advisor_group_id|
          NewsGroup.create!(news: @news, advisor_group_id: advisor_group_id, created_by: current_user.name)
        end
      end
      redirect_to news_index_path
    else
      render :new
    end
  end

  def edit
    @news = News.find(params[:id])
  end

  def update
    @news = News.find(params[:id])
    is_now_public = params[:category] == "All"
    was_public = @news.is_public?

    if @news.update(news_params.merge(is_public: is_now_public))
      @news.banner_image.attach(params[:banner_image]) if params[:banner_image]

      if params[:more_images]
        params[:more_images].each do |img|
          @news.more_images.attach(img)
        end
      end

      if is_now_public && !was_public
        # เปลี่ยนจากกลุ่ม → สาธารณะ → ลบกลุ่มเก่า
        @news.news_groups.destroy_all
      elsif !is_now_public
        # เปลี่ยนเป็นเฉพาะกลุ่ม → ลบกลุ่มเก่า แล้วสร้างใหม่
        @news.news_groups.destroy_all

        advisor_group_ids = AdvisorGroup.where(group_name: params[:category]).pluck(:id)
        advisor_group_ids.each do |advisor_group_id|
          NewsGroup.create!(news: @news, advisor_group_id: advisor_group_id, created_by: current_user.name)
        end
      end

      redirect_to news_index_path
    else
      render :edit
    end
  end


  private

  def news_params
    params.permit(:title, :content, :publish_date, :banner_image, more_images: [])
  end
end
