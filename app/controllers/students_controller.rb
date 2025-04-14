class StudentsController < ApplicationController
  def index
    advisor_group_member = AdvisorGroupMember.find_by(user_id: current_user.id)
    if advisor_group_member.present?
      @students = AdvisorRequest.where(advisor_group_member_id: advisor_group_member.id).page(params[:page]).per(5) # Paginate 4 per page
    else
      @students = AdvisorRequest.none.page(params[:page]).per(5)
    end
  end

  def student_requests
    existing_request = AdvisorRequest.find_by(
      student_id: current_user.id,
      advisor_group_member_id: params[:advisor_group_member_id]
    )

    if existing_request
      # ถ้ามีอยู่แล้ว → อัปเดตสถานะ
      existing_request.update(status: "pending")
    else
      # ถ้ายังไม่มี → สร้างใหม่
      AdvisorRequest.create!(
        student_id: current_user.id,
        advisor_group_member_id: params[:advisor_group_member_id],
        status: "pending",
        season_year_term: params[:year_term]
      )
    end

    redirect_to advisors_index_path(advisor_chosen: "true")
  end



  def my_student_group
    advisor_group_member = AdvisorGroupMember.find_by(user_id: current_user.id)

    if advisor_group_member.present?
      all_students = StudentGroupMember
        .includes(:user)
        .where(advisor_group_member_id: advisor_group_member.id)

      # กลุ่มตาม student_id แล้วเลือก record ที่ updated_at ล่าสุด
      @student = all_students
        .group_by(&:user_id)
        .values
        .map { |records| records.max_by(&:updated_at) }
    else
      @student = [] # หรือ redirect / render error / flash message ก็ได้
      flash[:alert] = "คุณยังไม่อยู่ในกลุ่มที่ปรึกษา"
      redirect_to root_path # หรือ path ที่เหมาะสม
    end
  end

  def my_group
    @advisor_group = AdvisorGroupMember.find_by(user_id: current_user.id)
    if @advisor_group.present?
      @advisor_group_members = AdvisorGroupMember.where(advisor_group_id: @advisor_group.advisor_group_id)

      if @advisor_group_members.present?
        @students = AdvisorGroupMember.where(advisor_group_id: @advisor_group.advisor_group_id)
      else
        @students = []
        redirect_to root_path
      end
    end
  end

  def destroy
    @advisor_request = StudentGroupMember.find(params[:id])
    @advisor_request.update(status: "rejected")
    redirect_to students_my_student_group_path, notice: "Request deleted successfully."
  end
end
