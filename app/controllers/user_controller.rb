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
        @user = User.new(name: params[:name],
             email: params[:email],
             password: params[:password],
             userImage: "default_image.jpg")
        if @user.save
            flash[:notice] = "登録しました"
            redirect_to("/user/#{@user.id}")
        else
            render("/user/userSignUp")
        end
    end

    def userLogin
        @user = User.find_by(name: params[:name], password: params[:password])
        if @user
          flash[:notice] = "ログインしました"
          redirect_to("/posts/index")
        else
            @errorMessage = "ログインに失敗"
            @name = params[:name]
            @password = params[:password]

            render("/top/indexTop")
        end

    end


    def userEdit
       @user = User.find_by(id: params[:id]) 
    end

    def userUpdate
        @user = User.find_by(id: params[:id])
        @user.name = params[:name]
        @user.email = params[:email]

        #画像保存処理
        if params[:image]
            @user.userImage = "#{@user.id}.jpg"
            image = MiniMagick::Image.read(params[:image])
            image.resize "100x120"
            image.write "public/user_images/#{@user.userImage}"
        end

        if @user.save
            flash[:notice] = "更新しました"
            redirect_to("/user/#{@user.id}")            
        else
            render("/user/#{@user.id}/userEdit")        
        end
    end

    def userDestroy
        @user = User.find_by(id: params[:id])   
        if @user.destroy
            flash[:notice] = "削除しました"
            redirect_to("/user/userList")            
        else
            render("/user/userList")        
        end
  end
end
