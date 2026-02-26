class UsersController < ApplicationController

    def create
        @user = User.new(register_params)
        if @user.save
            redirect_to new_api_v1_session_path, notice: "user created"
        else
            render :new , status: :unprocessable_entity
        end
    end

    def new
        @user = User.new
    end

    private

    def register_params
        params.require(:user).permit(:password,:email)
    end
end
