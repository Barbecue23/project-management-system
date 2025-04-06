class StudentsController < ApplicationController
  def index
    @students = AdvisorRequest.all.page(params[:page]).per(5) # Paginate 4 per page
  end

  def student_requests
    @advisor_requests = AdvisorRequest.create(
      student_id: current_user.id,
      advisor_group_member_id: params[:advisor_group_member_id],
      status: "pending",
      season_year_term: "-"
    )
  end

  def my_student_group
    @student = StudentGroupMember.all
  end
end
