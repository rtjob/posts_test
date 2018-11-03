## チルダ
---
Mac: `[option］＋［~］`  
~は左上tabの上　　
　 
　 

## bootstrapについて
---
###  VSCodeプレビュー
Mac: `[Command］＋［K］→［V］`  


## html.erbからボタンを使用して次画面遷移
---

#### postする場合(DB更新)

##### route.rb  
config/route.rb  


```rb
post "user/:id/userUpdate" => "user#userUpdate"
```

`user/:id/userUpdate`でurl指定　　
`user#userUpdate`でコントローラ側のメソッド指定　　

##### erb側   
---  

user/userEdit.html.erb

```erb
<%= form_tag("/user/#{user.id}/userUpdate") do %>
    <p class ="">名前</p>
    <input class="" name = "name" value="<%= @user.name %>">
    <p class ="">Eメール</p>
    <input class="" name = "email" value="<%= @user.email %>">
    <div class= "ml-auto p-2">
    <input type="submit" class="btn btn-primary btn-sm w-60" value="確定">
    </div>
<% end %>
```

form_tag("/user/#{user.id}/userUpdate") do  
url送信先　　

<%= @user.name %>  
更新先　　

ボタン押下でroute.rb `/user/#{user.id}/userUpdate`
で指定してたコントローラに遷移

##### contraller  
---
```rb
        @user = User.find_by(id: params[:id])
        @user.name = params[:name]
        @user.email = params[:email]
        if @user.save
            flash[:notice] = "更新しました"
            redirect_to("/user/#{@user.id}")            
        else
            render("/user/#{@user.id}/userEdit")        
        end
```
find_by param[:id]でDBをidで取得  
カラムで取得
@user.save成功したら
flash[:notice]で遷移先(redirect_to(route.rbに設定先設定))の  
noticeに出力









