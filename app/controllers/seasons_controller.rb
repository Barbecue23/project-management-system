class SeasonsController < ApplicationController
  def index
    @seasons = Season.all.page(params[:page]).per(5)
  end

  def new
    @seasons = Season.new
  end

  def create
    year = params[:season][:year].to_i
    term = params[:season][:term].to_i

    seasons_details = [ { "1": { year: year, term: term } } ]

    if term == 3
      seasons_details << { "2": { year: year + 1, term: 1 } }
      seasons_details << { "3": { year: year + 1, term: 2 } }
    elsif term == 2
      seasons_details << { "2": { year: year, term: 3 } }
      seasons_details << { "3": { year: year + 1, term: 1 } }
    elsif term == 1
      seasons_details << { "2": { year: year, term: 2 } }
      seasons_details << { "3": { year: year, term: 3 } }
    end

    @season = Season.new(season_params.merge(seasons_detail: seasons_details))

    if @season.save
      redirect_to seasons_path
    else
      render :new
    end
  end

  def edit
    @season = Season.find(params[:id])
  end

  def update
    @season = Season.find(params[:id])
    year = params[:season][:year].to_i
    term = params[:season][:term].to_i

    seasons_details = [ { "1": { year: year, term: term } } ]

    if term == 3
      seasons_details << { "2": { year: year + 1, term: 1 } }
      seasons_details << { "3": { year: year + 1, term: 2 } }
    elsif term == 2
      seasons_details << { "2": { year: year, term: 3 } }
      seasons_details << { "3": { year: year + 1, term: 1 } }
    elsif term == 1
      seasons_details << { "2": { year: year, term: 2 } }
      seasons_details << { "3": { year: year, term: 3 } }
    end

    if @season.update(season_params.merge(seasons_detail: seasons_details))
      redirect_to seasons_index_path
    else
      render :edit
    end
  end

  def destroy
    @season = Season.find_by(id: params[:id])

    if @season
      @season.destroy
      flash[:success] = "Season ถูกลบเรียบร้อยแล้ว"
    else
      flash[:error] = "ไม่พบ Season ที่ต้องการลบ"
    end

    redirect_to seasons_path
  end


  private

  def season_params
    params.require(:season).permit(:start_date, :end_date, :season_name)
  end
end
