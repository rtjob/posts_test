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
        @user = User.new
    end

    def userCreate
        @user = User.new(name: params[:name], email: params[:email])
        if @user.save
            flash[:notice] = "登録しました"
            redirect_to("/user/#{@user.id}")
        else
            render("/user/userSignUp")
        end
    end

    def userEdit
       @user = User.find_by(id: params[:id]) 
    end

    def userUpdate
        @user = User.find_by(id: params[:id])
        @user.name = params[:name]
        @user.email = params[:email]
        if @user.save
            flash[:notice] = "更新しました"
            redirect_to("/user/#{@user.id}")            
        else
            render("/user/#{@user.id}/userEdit")        
        end
    end
end
