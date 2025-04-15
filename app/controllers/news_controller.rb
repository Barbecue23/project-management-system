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

      if params[:news][:more_images]
        @news.more_images.attach(params[:news][:more_images])
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
