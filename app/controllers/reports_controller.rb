class ReportsController < ApplicationController
  before_action :set_record, only: [ :edit, :update, :destroy ]

  def index
    if params[:tab] == "projects"
      @records = Record.where(record_type: :project).page(params[:page]).per(5)
    else
      @records = Record.where(record_type: :report).page(params[:page]).per(5)
    end
  end
  def new
    @record_type = params[:record_type]
    redirect_to reports_select_type_path, alert: "กรุณาเลือกประเภทก่อน" unless @record_type.present?
    @record = Record.new(record_type: @record_type)
  end


  def create
    @record = Record.new(record_params)
    if @record.save
      redirect_to reports_index_path, notice: "บันทึกเรียบร้อยแล้ว"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @record.update(record_params)
      redirect_to reports_index_path, notice: "อัปเดตเรียบร้อยแล้ว"
    else
      render :edit
    end
  end

  def destroy
    @record.destroy
    redirect_to reports_index_path, notice: "ลบเรียบร้อยแล้ว"
  end

  private

  def set_record
    @record = Record.find(params[:id])
  end

  def record_params
    params.require(:record).permit(:title, :student_name, :year, :category, :record_type, :file)
  end
end
