### やりたいこと

railsにてfind_byした際にエラーメッセージを出力したいが
DocumentsNotFoundが出た

##### ログイン時に存在しないユーザ入力

画面にて 
DBに存在するデータ入力した場合はfind_byで取得できるが
DBに存在しないデータを入力時にDocumentsNotFoundエラー

ログイン画面
![ログイン画面](PostsTest login.png)

```erb
    <%= form_tag("/user/login") do%>
        <p class ="">名前</p>
            <input class="w-150" name = "name" value = "<%= @name%>">
        <div class= "ml-auto p-2">
            <input type="submit" class="btn btn-primary btn-sm w-60" value="ログイン">
        </div>
    <% end %>
```

```rb
def userLogin
    @user = User.find_by(name: params[:name])
    if @user
        ###ログイン成功時処理
    else
        ###ログイン失敗時時処理
    end
end
```
error
![DocuentNotFound](DocumentNotFound.png)


### 環境
-rails v5.2.1
-mongoDB v4.0.2

### 原因

mongoDBの場合、レコード検索時にレコードがない時に
`raise_not_found_error: false`で例外をあげずに
DocumentNotFoundを返すらしい
[Mongoidの隠れクエリメソッドfind_by!とraise_not_found_errorオプションの関係](https://qiita.com/IzumiSy/items/9c1500dcc907db6b44b6)  

###　対策  
`raise_not_found_error: false`を  
`raise_not_found_error: true`にすれば
find_byにした際にレコードがない場合にnilとなり
DocumentNotFoundにはなくなる

`raise_not_found_error`はconfig/mongoid.ymlに存在します
[Rails3 対応 MongoDB ORM、Mongoid 詳解―インストール](http://babie.hatenablog.com/entry/20100809/1281316972)
デフォルトではtrueになってます  
```config/mongoid.yml
# Raise an error when performing a #find and the document is not found.
# (default: true)
# raise_not_found_error: true
```

```config/mongoid.yml
# Raise an error when performing a #find and the document is not found.
# (default: true)
raise_not_found_error: false
```

###　結果
変更後は
```
rails s
```
でrailsを再起動しましょう

![ログイン失敗画面](LoginFalse.png)

無事エラー画面になりました






