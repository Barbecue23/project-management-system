class NewsController < ApplicationController
  def index
    if current_user
      @user_group_ids = AdvisorGroupMember.where(user_id: current_user.id).pluck(:advisor_group_id)

      @news = News.includes(:banner_image_attachment, :news_groups)
                  .order(publish_date: :desc)
                  .select { |news|
                    is_owner = news.created_by == current_user.name
                    is_published = news.publish_date <= Date.today
                    is_public = news.is_public
                    news_group_ids = news.news_groups.map(&:advisor_group_id)
                    is_in_group = (news_group_ids & @user_group_ids).any?

                    is_owner || (is_published && (is_public || is_in_group))
                  }
    else
      @news = News.includes(:banner_image_attachment, :news_groups)
                  .where("publish_date <= ? AND is_public = true", Date.today)
                  .order(publish_date: :desc)

      @user_group_ids = []
    end
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

    if params[:news][:more_images].reject(&:blank?).size > 6
      flash[:alert] = "ไม่สามารถอัปโหลดรูปมากกว่า 5 รูปได้"
      redirect_to new_news_path and return
    end


    if @news.save

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
    @news.category = @news.is_public? ? "All" : @news.news_groups.first&.advisor_group&.group_name
    is_now_public = params[:category] == "All"
    was_public = @news.is_public?

    # เช็ค banner image ว่าแนบมาไหม
    banner_count = params[:news][:banner_image].present? ? 1 : (@news.banner_image.attached? ? 1 : 0)

    # เช็คจำนวนรูปเดิม + ใหม่
    existing_more_images_count = @news.more_images.count
    new_more_images = params[:news][:more_images].reject(&:blank?) rescue []
    total_more_images = existing_more_images_count + new_more_images.size

    total_image_count = banner_count + total_more_images

    if total_image_count > 6
      flash[:alert] = "ไม่สามารถอัปโหลดรูปภาพรวมเกิน 6 รูปได้"
      redirect_to news_edit_path(@news) and return
    end

    if @news.update(news_params.merge(is_public: is_now_public).except(:more_images))

      if params[:news][:more_images].present?
        params[:news][:more_images].each do |image|
          @news.more_images.attach(image)
        end
      end

      if is_now_public && !was_public
        @news.news_groups.destroy_all
      elsif !is_now_public
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

  def destroy
    @news = News.find(params[:id])

    # ลบ banner_image ถ้ามี
    @news.banner_image.purge_later if @news.banner_image.attached?

    # ลบรูปทั้งหมดใน more_images ถ้ามี
    @news.more_images.each(&:purge_later) if @news.more_images.attached?

    # ลบ record ข่าว
    @news.destroy

    redirect_to news_index_path, notice: "ลบข่าวสารเรียบร้อยแล้ว"
  end


  def delete_attachment
    attachment = ActiveStorage::Attachment.find(params[:id])
    attachment.purge_later
    head :ok
  end
  private

  def news_params
    params.require(:news).permit(:title, :content, :publish_date, :banner_image, more_images: [])
  end
end
