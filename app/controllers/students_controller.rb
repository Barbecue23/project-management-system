class StudentsController < ApplicationController
  def index
    advisor_group_member = AdvisorGroupMember.find_by(user_id: current_user.id)
    @seasons = Season.where(status: 1)

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
    @seasons = Season.all.order(created_at: :asc)
    @selected_season = Season.find_by(id: params[:season_id]) || @seasons.first

    if advisor_group_member.present?
      all_students = StudentGroupMember
        .includes(:user)
        .where(advisor_group_member_id: advisor_group_member.id)
        .where(season_id: @selected_season.id) # กรองตามซีซั่น

      @students = all_students
        .group_by(&:user_id)
        .values
        .map { |records| records.max_by(&:updated_at) }
    else
      flash[:alert] = "คุณยังไม่อยู่ในกลุ่มที่ปรึกษา"
      redirect_to root_path and return
    end
  end


  def destroy
    @student_member = StudentGroupMember.find(params[:id])

    if @student_member.update(status: "rejected")
      student_id = @student_member.user_id
      advisor_id = @student_member.advisor_group_member_id

      if student_id.present? && advisor_id.present?
        advisor_request = AdvisorRequest.find_by(
          student_id: student_id,
          advisor_group_member_id: advisor_id
        )

        advisor_request&.update(status: "rejected")
      end

      redirect_to students_my_student_group_path, notice: "Request rejected successfully."
    else
      redirect_to students_my_student_group_path, alert: "เกิดข้อผิดพลาดในการปฏิเสธคำขอ"
    end
  end
end
