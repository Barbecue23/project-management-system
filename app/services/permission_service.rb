class PermissionService
  def initialize(user)
    @user = user
  end

  def can_view?(permission_name)
    return false unless valid_user?

    @user.role.map_permissions.joins(:permission)
         .where(permissions: { name: permission_name }, can_view: true)
         .exists?
  end

  def can_create?(permission_name)
    return false unless valid_user?

    @user.role.map_permissions.joins(:permission)
         .where(permissions: { name: permission_name }, can_create: true)
         .exists?
  end

  def can_edit?(permission_name)
    return false unless valid_user?

    @user.role.map_permissions.joins(:permission)
         .where(permissions: { name: permission_name }, can_edit: true)
         .exists?
  end

  def can_delete?(permission_name)
    return false unless valid_user?

    @user.role.map_permissions.joins(:permission)
         .where(permissions: { name: permission_name }, can_delete: true)
         .exists?
  end

  private

  def valid_user?
    @user.present? && @user.role.present?
  end
end
