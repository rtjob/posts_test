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









