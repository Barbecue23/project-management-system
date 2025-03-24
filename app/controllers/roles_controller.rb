class RolesController < ApplicationController
  before_action :set_users_and_permissions, only: [ :new, :create ]

  def index
    @roles = Role.includes(:users, :permissions).all
  end

  def new
    @role = Role.new
    @map_permission = MapPermission.new
  end

  def create
    @role = Role.new(role_params.merge(created_by: "system", updated_by: "system"))

    return render :new unless @role.save

    assign_users_to_role
    assign_permissions_to_role

    redirect_to roles_path
  end

  def edit
    @role = Role.find(params[:id])
  end

  def update
    @role = Role.find(params[:id])

    if @role.update(role_params)
      # อัปเดต Users ที่เกี่ยวข้อง
      @role.users = User.where(id: params[:user_ids])

      # อัปเดต Permissions
      @role.map_permissions.each do |map_perm|
        perm_params = params[:permissions][map_perm.permission_id.to_s] || {}
        map_perm.update(
          can_view: perm_params[:can_view].present?,
          can_create: perm_params[:can_create].present?,
          can_edit: perm_params[:can_edit].present?,
          can_delete: perm_params[:can_delete].present?
        )
      end

      flash[:notice] = "Role updated successfully."
      redirect_to roles_path
    else
      flash[:alert] = "Failed to update role."
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def role_params
    params.require(:role).permit(:name)
  end

  def set_users_and_permissions
    @users = User.all
    @permissions = Permission.all
  end

  def assign_users_to_role
    user_ids = params[:user_ids] || []
    User.where(id: user_ids).update_all(role_id: @role.id)
  end

  def assign_permissions_to_role
    (params[:permissions] || {}).each do |perm_id, values|
      MapPermission.create!(
        role_id: @role.id,
        permission_id: perm_id,
        can_view: values[:can_view].present?,
        can_create: values[:can_create].present?,
        can_edit: values[:can_edit].present?,
        can_delete: values[:can_delete].present?
      )
    end
  end
end
