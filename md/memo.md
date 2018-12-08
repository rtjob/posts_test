## チルダ
---
Mac: `[option］＋［~］`  
~は左上tabの上　　
　 
　 

## bootstrapについて
---
###  MarkDownプレビュー
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




##　Progate Rails 7

- ユーザ一覧に画像を紐づける方法

-- DB情報から画像を紐づけて表示する方法

### DBカラム追加

画像ファイル名を格納するカラムを追加

#### MongoDB
(コレクション:usersの場合）
新規カラム(insert)

`db.collection.insert(
{hoge:'fuga', … ,image_data:'default_user.jpg'})`

既存カラム(update)
`db.user.update({name:'testname'}, {$set:{image_data:'default_user.jpg'}})`

### 格納先フォルダ
public/user_images
に格納することを想定


### 画像表示

#### collection側
デフォルト画像を表示する場合

newする際に追加したカラムおよび画像名を設定

例
```ruby
  def create
    @user = User.new(
      name: params[:name],
      email: params[:email],
      image_name: "default_user.jpg"
    )
    end
```
new.html.erb
' <img src="<%= "/user_images/#{@user.image_name}" %>"> '


### view設定
imgタグ内でpublicフォルダーを指定。

例

一覧の表示
show.html.erb
' <img src="<%= "/user_images/#{@user.image_name}" %>"> '

user_controller.rb
```
def show
    @user = User.find_by(id: params[:id])
end
```

### 画像を登録する場合

#### view側

show.html.erb
inputタグでフォーム指定
'<input name="image" type="file">'
controll側updateメソッドで処理するため

form_tagでupdate指定
ただし
'「画像を送信したいときには{multipart: true}'をつける必要がある」

`<%= form_tag("/users/#{@user.id}/update", {multipart: true}) do %>`


####　collection側

画像名をidに指定したい場合、
'''erb  
def update
@user = User.find_by(id: params[:id])

@user.image_name = "#{@user.id}.jpg"
end
''

ビュー側で'name="image"'を指定していた場合
コントローラ側で'param[:image]'で値を受けて取れる

File.binwriteで指定場所に書き込みできる
-第一引数　パス
-第二引数 画像読み込み(read指定)
'      image = params[:image]
      File.binwrite("public/user_images/#{@user.image_name}",image.read)'







## コントローラ作成
'''
rails generate controller コントローラ名
'''

## heroku logみる
heroku logs -t

## heroku　configみる
heroku config


## heroku 環境　mongoDB読む
mongo ds037977.mlab.com:37977/heroku_9v5bk0vx -u heroku_9v5bk0vx -p 8sqkanmmqjtjqojfk7828ukr4v

## VSCODE でデバック
bundle exec rdebug-ide --host 127.0.0.1 --port 1234 --dispatcher-port 26162 -- bin/rails s