###画像up方法
画像をアップする画面の作成方法
ここではサイズを固定する場合


###準備
リサイズを行うために、ImageMagickと対応するGemのMiniMagickをインストールする
大いに参考になりました:
[[備忘録]railsで画像をリサイズしてアップロード](https://qiita.com/tontoko/items/f2e889fda34ee07d973d)

Macの場合
`brew install imagemagick`

インストールされているかチェック。
`convert --version`

Gemfileにmini_magickを追加
`gem 'mini_magick'`

bundle install
`bundle install`

### model
field追加

例
`field :userImage, type: String`

#### View側
form_tagに{multipart: true}をつける
input fileで画像選択できる
例
```rb
<%= form_tag("/user/#{@user.id}/userUpdate", {multipart: true}) do %>
  <p class ="">画像</p>
    <input name="image" type="file">

<% end %>
```


####controller側
resizeでサイズ変更しwriteで保存
例
```erb
    def userUpdate
        @user = User.find_by(id: params[:id])
        ###諸々処理

        #画像保存処理
        if params[:image]
            @user.userImage = "#{@user.id}.jpg"
            image = MiniMagick::Image.read(params[:image])
            #画像サイズ固定
            image.resize "100x120"
            image.write "public/user_images/#{@user.userImage}"
        end

        @user.save         
    end
```
