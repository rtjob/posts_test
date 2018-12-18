class UserController < ApplicationController
    before_action :authenticate_user,{only:[:userDetail,:userEdit,:userUpdate,:userDestroy]}

    before_action :forbit_loginUser,{only:[:userSignUp,:userCreate,:userLogin]}

    before_action :authenticate_root_user,{only:[:userList]}  

    before_action :ensure_correct_user,{only:[:userEdit,:userUpdate,:userDestroy]}

    def userList
        @allUsers = User.all
        logger.debug("@user=" + @users.inspect)
        @allUsers.each do |user|
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
            session[:user_id] = @user.id
            flash[:notice] = "登録しました"
            redirect_to("/user/#{@user.id}")
        else
            render("/user/userSignUp")
        end
    end

    def userLogin
        # @user = User.find_by(name: params[:name], password: params[:password])
        @user = User.find_by(name: params[:name])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id

            flash[:notice] = "ログインしました"
            redirect_to("/posts/index")
        else
            @errorMessage = "ログインに失敗"
            @name = params[:name]
            @password = params[:password]

            render("/top/indexTop")
        end

    end

    def userLogout
        session[:user_id] = nil
        flash[:notice] = "ログアウトしました"
        redirect_to("/indexTop")
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

    def userDestroyFromUserList
        @user = User.find_by(id: params[:id])
        @post = Post.find_by(user_id: params[:id])
        if @user.destroy
            if @post.present?
                @post.destroy
            end
            flash[:notice] = "ユーザー情報を削除しました"
            redirect_to("/user/userList")            
        else
            render("/user/userList")        
        end
    end

    def userDestroy
        @user = User.find_by(id: params[:id])
        @post = Post.find_by(user_id: params[:id])
        if @user.destroy
            if @post.present?
                @post.destroy
            end
            flash[:notice] = "ユーザー情報を削除しました"
            @current_user.id = nil
            redirect_to("/indexTop")            
        else
            render("/user/#{@user.id}/userEdit")        
        end
    end

    def like
        @user = User.find_by(id: params[:id])
        @likes = Like.where(user_id: @user.toString())
    end

    def ensure_correct_user
        # BSON::ObjectId.from_string(params[:id]) string→BSON:ObjectID
        if @current_user.id != BSON::ObjectId.from_string(params[:id]) && @current_user.name != "管理人"
            flash[:notice] = "権限がありません"
            redirect_to("/posts/index")
        end
  end
end
