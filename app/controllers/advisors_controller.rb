class AdvisorsController < ApplicationController
  def index
    # advisors = [
    #   { id: 1, name: "อ.ดร.สัจจาภรณ์ ไวยญาณ", position: "Dr.Saijaporn Waijanya", specialty: "Software Engineer", specialty_details: "ดูเพิ่มเติม", email: "waijanya_s@silpakorn.edu", alternate_email: "saijaporn.w@gmail.com", current_students: 4, max_students: 6, status: "active" },
    #   { id: 2, name: "อ.ดร.สัจจาภรณ์ ไวยญาณ", position: "Dr.Saijaporn Waijanya", specialty: "Software Engineer", specialty_details: "ดูเพิ่มเติม", email: "waijanya_s@silpakorn.edu", alternate_email: nil, current_students: 6, max_students: 6, status: "active" },
    #   { id: 3, name: "อ.ดร.สัจจาภรณ์ ไวยญาณ", position: "Dr.Saijaporn Waijanya", specialty: "Software Engineer", specialty_details: "ดูเพิ่มเติม", email: "waijanya_s@silpakorn.edu", alternate_email: "saijaporn.w@gmail.com", current_students: 4, max_students: 6, status: "active" },
    #   { id: 4, name: "อ.ดร.สัจจาภรณ์ ไวยญาณ", position: "Dr.Saijaporn Waijanya", specialty: "Software Engineer", specialty_details: "ดูเพิ่มเติม", email: "waijanya_s@silpakorn.edu", alternate_email: "saijaporn.w@gmail.com", current_students: 6, max_students: 10, status: "active" },
    #   { id: 5, name: "อ.ดร.สัจจาภรณ์ ไวยญาณ", position: "Dr.Saijaporn Waijanya", specialty: "Software Engineer", specialty_details: "ดูเพิ่มเติม", email: "waijanya_s@silpakorn.edu", alternate_email: "saijaporn.w@gmail.com", current_students: 7, max_students: 10, status: "active" },
    #   { id: 6, name: "อ.ดร.สัจจาภรณ์ ไวยญาณ", position: "Dr.Saijaporn Waijanya", specialty: "Software Engineer", specialty_details: "ดูเพิ่มเติม", email: "waijanya_s@silpakorn.edu", alternate_email: nil, current_students: 3, max_students: 6, status: "active" },
    #   { id: 7, name: "อ.ดร.สมชาย สุทธิกุล", position: "Dr.Somchai Suthikul", specialty: "Data Scientist", specialty_details: "วิทยาการข้อมูล", email: "somchai.s@silpakorn.edu", alternate_email: "somchai.suthikul@gmail.com", current_students: 8, max_students: 10, status: "inactive" },
    #   { id: 8, name: "อ.ดร.ณัฐณิชา สมใจ", position: "Dr.Nattanicha Somjai", specialty: "UI/UX Designer", specialty_details: "ออกแบบประสบการณ์ผู้ใช้", email: "nattanicha.somjai@silpakorn.edu", alternate_email: "nattanicha.design@gmail.com", current_students: 2, max_students: 5, status: "active" },
    #   { id: 9, name: "อ.ดร.ไกรสร พานิช", position: "Dr.Kraisorn Panit", specialty: "Cybersecurity", specialty_details: "ความปลอดภัยไซเบอร์", email: "kraisorn.panit@silpakorn.edu", alternate_email: "kraisorn.panit@gmail.com", current_students: 5, max_students: 8, status: "active" },
    #   { id: 10, name: "อ.ดร.ชินาวรรธน์ กิจบรรจง", position: "Dr.Chinawat Kijbanjong", specialty: "Cloud Computing", specialty_details: "คอมพิวเตอร์คลาวด์", email: "chinawat.k@silpakorn.edu", alternate_email: nil, current_students: 9, max_students: 10, status: "active" }
    # ]

    # @advisors = Kaminari.paginate_array(advisors).page(params[:page]).per(5) # Paginate 4 per page
    @advisors_group_members = AdvisorGroupMember.includes(:user).page(params[:page]).per(5)
  end

  def new
    @advisor_group = AdvisorGroup.new
  end

  def create
    @advisor_group = AdvisorGroup.new(advisor_group_params.merge(owner_id: 1))

    if @advisor_group.save
      # ตรวจสอบ owner และเพิ่มเข้าไปในกลุ่มถ้ายังไม่มี
      is_owner = AdvisorGroupMember.find_by(user_id: @advisor_group.owner_id)
      if is_owner.nil? || !is_owner.is_owner
        AdvisorGroupMember.create!(advisor_group: @advisor_group, user_id: @advisor_group.owner_id, is_owner: true)
      end

      user_ids = params[:user_ids] || []
      @advisor_group_members = user_ids.map do |user_id|
        existing_member = AdvisorGroupMember.find_by(user_id: user_id)

        if existing_member.nil?
          # ✅ ถ้ายังไม่มีอยู่ในระบบ → สร้างใหม่
          AdvisorGroupMember.create!(advisor_group: @advisor_group, user_id: user_id, is_owner: false)
        elsif !existing_member.is_owner && existing_member.advisor_group_id != @advisor_group.id
          # 🔄 ถ้ามีอยู่แล้วแต่เป็นกลุ่มอื่น และไม่ใช่ owner → อัปเดตให้ย้ายมาอยู่กลุ่มใหม่
          existing_member.update!(advisor_group: @advisor_group)
        end
      end

      redirect_to advisors_new_path
    else
      render :new
    end
  end

  def detail_group
    @advisor_group = AdvisorGroup.all
    @selected_group = AdvisorGroup.find_by(id: params[:group_id]) || @advisor_group.first

    @advisors_in_group = User
      .joins(:advisor_group_members)
      .where(advisor_group_members: { advisor_group_id: @selected_group.id })
  end

  def advisor_group_overview
    @groups = AdvisorGroup.all
    @selected_group = AdvisorGroup.find_by(id: params[:group_id]) || @groups.first

    if @selected_group
      @advisors_in_group = User
        .joins(:advisor_group_members)
        .where(advisor_group_members: { advisor_group_id: @selected_group.id })
        .where(role_id: Role.find_by(name: "advisor")&.id)
    else
      @advisors_in_group = []
    end
  end
  def edit
    @advisor_group = AdvisorGroup.find(params[:id])
    @advisor_group_members = @advisor_group.advisor_group_members.pluck(:user_id)
  end

  def update
    @advisor_group = AdvisorGroup.find(params[:id])

    if @advisor_group.update(advisor_group_params)
      # ✅ อัปเดต Owner ถ้ายังไม่มี
      owner_member = AdvisorGroupMember.find_or_initialize_by(user_id: @advisor_group.owner_id, advisor_group: @advisor_group)
      owner_member.update!(is_owner: true)

      # ✅ อัปเดตสมาชิกกลุ่ม
      user_ids = params[:user_ids] || []
      existing_member_ids = @advisor_group.advisor_group_members.pluck(:user_id)

      # 🔹 เพิ่มหรืออัปเดตสมาชิกที่เลือก
      user_ids.each do |user_id|
        member = AdvisorGroupMember.find_or_initialize_by(user_id: user_id, advisor_group: @advisor_group)
        member.update!(is_owner: false)
      end

      # 🔥 ลบสมาชิกที่ไม่ได้ถูกเลือก
      members_to_remove = existing_member_ids - user_ids.map(&:to_i)
      @advisor_group.advisor_group_members.where(user_id: members_to_remove).destroy_all

      # 🎯 สำเร็จ → Redirect
      redirect_to advisors_detail_group_path, notice: "Advisor Group updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def student_requests
    @advisor_requests = AdvisorRequest.create(
      student_id: 3,
      advisor_group_member_id: params[:advisor_group_member_id],
      status: "pending",
      season_year_term: "-"
    )
  end

  def requests
    @advisor_requests = AdvisorRequest.includes(student: :advisor_group_members).all
  end

  def accept_request
    @advisor_request = AdvisorRequest.find(params[:id])
    @student_group_members = StudentGroupMember.create(
      user_id: @advisor_request.student.id,
      season_id: 6,
      year_term: "2567/3",
      advisor_group_member_id: @advisor_request.advisor_group_member_id
    )
    if @student_group_members.save
      @advisor_request.update(status: "accepted")
      redirect_to advisors_requests_path
    end
  end

  def reject_request
    @advisor_request = AdvisorRequest.find(params[:id])
    @advisor_request.update(status: "rejected")
    redirect_to advisors_requests_path
  end
  private

  def advisor_group_params
    params.require(:advisor_group).permit(:group_name)
  end
end
