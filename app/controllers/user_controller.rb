class UserController < ApplicationController

    def userList
        @users = User.all
        logger.debug("@user=" + @users.inspect)
        @users.each do |user|
            logger.debug("user.name=" + user.name.inspect)
        end
    end

    def userDetail
        @users = User.find_by(id: params[:id])
    end

    def userSignUp

    end

    def userCreate
        @user = User.new(name: params[:name], email: params[:email])
        @user.save
        redirect_to("/user/#{@user.id}")
    end
end
