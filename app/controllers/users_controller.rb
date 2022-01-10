class UsersController < ApplicationController
    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            user_profile = Profile.create(user_id: @user.id)
            user_profile.image.attach(io: File.open('app/assets/images/download.png'),
                                      filename: 'image_1.png')
            user_profile.save
            log_in(@user)
            flash[:success] = "Registered successfully!"
            redirect_to edit_path
        else
            count_flash_msg = 0
            @user.errors.full_messages.each do |m|
                flash[count_flash_msg] = m
                count_flash_msg = count_flash_msg + 1
            end
            render 'new'
        end
    end

    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end  
end
