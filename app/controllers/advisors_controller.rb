class AdvisorsController < ApplicationController
  def index
    @advisors_group_members = AdvisorGroupMember
  .includes(:user)
  .left_joins(:student_group_members)
  .select("advisor_group_members.*, COUNT(student_group_members.id) AS student_count")
  .group("advisor_group_members.id")
  .page(params[:page]).per(5)

  @advisor_requests = AdvisorRequest.where(status: [ "pending", "accepted" ], student_id: current_user.id).order(created_at: :desc).first
  @student_group_members = StudentGroupMember.where(user_id: current_user.id, status: "accepted")

  puts "111: ", @advisor_requests.inspect
  puts "555: ", @student_group_members.inspect
  end

  def new
    @advisor_group = AdvisorGroup.new
  end

  def create
    @advisor_group = AdvisorGroup.new(advisor_group_params)

    if !AdvisorGroup.find_by(owner_id: params[:owner_id])
      @advisor_group.owner_id = params[:owner_id]
    end

    if @advisor_group.save
      is_owner_member = AdvisorGroupMember.find_by(user_id: @advisor_group.owner_id)
      if is_owner_member
        puts "Owner already exists"

        if !is_owner_member.is_owner || is_owner_member.advisor_group_id != @advisor_group.id
          is_owner_member.update!(
            advisor_group: @advisor_group,
            is_owner: true
          )
        end

        user_ids = (params[:user_ids] || []).map(&:to_i).reject { |uid| uid == @advisor_group.owner_id }

        user_ids.each do |user_id|
          member = AdvisorGroupMember.find_or_initialize_by(user_id: user_id)

          if member.new_record?
            # กรณีใหม่
            member.advisor_group = @advisor_group
            member.is_owner = false
            member.save!
          elsif member.advisor_group_id != @advisor_group.id
            # มีอยู่แล้ว → ย้ายกลุ่ม & อัปเดต
            member.update!(advisor_group: @advisor_group, is_owner: false)
          else
            # อยู่ในกลุ่มเดียวกันแล้ว → ไม่ต้องทำอะไร
            puts "User #{user_id} is already in the group"
          end
        end
      else
        puts "Owner does not exist"
        owner_member = AdvisorGroupMember.find_or_initialize_by(
          user_id: @advisor_group.owner_id,
          advisor_group: @advisor_group
        )
        owner_member.is_owner = true
        owner_member.save!

        user_ids = (params[:user_ids] || []).map(&:to_i).reject { |uid| uid == @advisor_group.owner_id }

        user_ids.each do |user_id|
          member = AdvisorGroupMember.find_or_initialize_by(user_id: user_id)

          if member.new_record?
            # กรณีใหม่
            member.advisor_group = @advisor_group
            member.is_owner = false
            member.save!
          elsif member.advisor_group_id != @advisor_group.id
            # มีอยู่แล้ว → ย้ายกลุ่ม & อัปเดต
            member.update!(advisor_group: @advisor_group, is_owner: false)
          else
            # อยู่ในกลุ่มเดียวกันแล้ว → ไม่ต้องทำอะไร
            puts "User #{user_id} is already in the group"
          end
        end

      end

      # 🎯 สำเร็จ → Redirect
      redirect_to advisors_detail_group_path, notice: "Advisor Group created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def detail_group
    admin_role_id = Role.find_by(name: "ผู้ดูแลระบบ")&.id

    if current_user.role_id == admin_role_id
      @advisor_group = AdvisorGroup.all
    else
      @advisor_group = AdvisorGroup
        .joins(:advisor_group_members)
        .where(advisor_group_members: { user_id: current_user.id })
    end

    @selected_group = AdvisorGroup.find_by(id: params[:group_id]) || @advisor_group.first

    if @selected_group.nil?
      @advisors_in_group = []
    else
      @advisors_in_group = User
        .joins(:advisor_group_members)
        .where(advisor_group_members: { advisor_group_id: @selected_group.id })
    end
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
    @advisor_group_members = @advisor_group.advisor_group_members.where(is_owner: false).pluck(:user_id)
  end

  def update
    @advisor_group = AdvisorGroup.find(params[:id])

    if @advisor_group.update(advisor_group_params)
      # ✅ ยืนยันให้ owner เป็น owner จริง ๆ
      owner_member = AdvisorGroupMember.find_or_initialize_by(
        user_id: @advisor_group.owner_id,
        advisor_group: @advisor_group
      )
      owner_member.update!(is_owner: true)

      # ✅ ทำงานเฉพาะสมาชิกที่ไม่ใช่ owner
      user_ids = (params[:user_ids] || []).map(&:to_i)
      user_ids.reject! { |uid| uid == @advisor_group.owner_id }

      # สมาชิกเก่าที่ไม่ใช่ owner
      existing_member_ids = @advisor_group.advisor_group_members.where(is_owner: false).pluck(:user_id)

      user_ids.each do |user_id|
        member = AdvisorGroupMember.find_by(user_id: user_id)

        if member.nil?
          # ไม่เคยอยู่ในกลุ่มไหนเลย → สร้างใหม่
          AdvisorGroupMember.create!(
            user_id: user_id,
            advisor_group: @advisor_group,
            is_owner: false
          )
        elsif member.advisor_group_id != @advisor_group.id
          # เคยอยู่กลุ่มอื่น → ย้ายกลุ่ม
          member.update!(
            advisor_group: @advisor_group,
            is_owner: false
          )
        else
          # อยู่ในกลุ่มนี้อยู่แล้ว → แค่อัปเดต (กันไว้)
          member.update!(is_owner: false)
        end
      end

      # 🔥 ลบสมาชิกที่ไม่ได้เลือก (ยกเว้น owner)
      members_to_remove = existing_member_ids - user_ids
      @advisor_group.advisor_group_members.where(user_id: members_to_remove, is_owner: false).destroy_all

      redirect_to advisors_detail_group_path, notice: "Advisor Group updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def requests
    @advisor_requests = AdvisorRequest.includes(student: :advisor_group_members).all
  end

  def accept_request
    @advisor_request = AdvisorRequest.find(params[:id])
    existing_request = StudentGroupMember.find_by(user_id: @advisor_request.student.id)

    if existing_request
      existing_request.update(
        status: "accepted",
        advisor_group_member_id: @advisor_request.advisor_group_member_id
      )
      success = true
    else
      @student_group_member = StudentGroupMember.new(
        user_id: @advisor_request.student.id,
        season_id: 1,
        year_term: "2567/3",
        advisor_group_member_id: @advisor_request.advisor_group_member_id,
        status: "accepted"
      )
      success = @student_group_member.save
    end

    if success
      @advisor_request.update(status: "accepted")
      redirect_to students_index_path, notice: "อนุมัติคำขอแล้ว"
    else
      redirect_to students_index_path, alert: "เกิดข้อผิดพลาดในการอนุมัติ"
    end
  end


  def reject_request
    @advisor_request = AdvisorRequest.find(params[:id])
    @advisor_request.update(status: "rejected")
    redirect_to students_index_path
  end
  private

  def advisor_group_params
    params.require(:advisor_group).permit(:group_name)
  end
end
