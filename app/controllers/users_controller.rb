class UsersController < ApplicationController
    def add_user
        @user = User.new
        @role = Role.all
      end

      def create_user
        @user = User.new(user_params)
        @user.password = Devise.friendly_token[0, 20]

        if @user.save
          redirect_to roles_path, notice: "User was successfully created."
        else
          render :add_user, status: :unprocessable_entity
        end
      end

      private
      def user_params
        params.require(:user).permit(:name, :email, :expertise, :role_id)
      end
end
