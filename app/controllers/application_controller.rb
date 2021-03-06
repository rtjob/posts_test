class ApplicationController < ActionController::Base
    before_action :setCurrentUser
    
    def setCurrentUser
        if session[:user_id]
            @current_user = User.find(session[:user_id]) 
        end

    end

    def authenticate_user
        if @current_user == nil
            flash[:notice]="ログインして下さい"
            redirect_to("/indexTop")
        end
    end

    def forbit_loginUser
        if @current_user
            flash[:notice]="ログイン中です"
            redirect_to("/posts/index")
        end
    end

    def authenticate_root_user
        if @current_user.name != "管理人"
            flash[:notice]="管理者のみアクセスできます"
            if @current_user
                redirect_to("/posts/index")
            else
                redirect_to("/indexTop")
            end
        end
    end
end
