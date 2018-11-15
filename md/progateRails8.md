##　Progate Rails 8
### 認証:
ログイン状態とログインしていない状態よる表示違い。

ログインしていない状態では見せないページおよび
ログインしている状態で見せるページの設定方法

ログイン状態の保持方法 


##### ログインページ作成時
routes.rb  
'get "login" => "user#login_form"'

erbでは入力内容を見えなくする必要あり  
`<input type="password">`  

#### DB側設定

コンソール側処理  
add_カラム_to_コレクション名で
カラム追加用マイグレーションファイル作成
'rails g migration add_password_to_users'

model側処理
マイグレ用ファイルに
コレクション 、カラム、型を追加
'add_column: :user, :password, ;string'

コンソール側処理  
'rails db:migrate'

### パスワード保存
routes.rb post追加
`post "login" => "users#login"`

view側
```
<%= form_tag("/login") do%>
<input type="password" name="password">
```  
コントローラ側
```
def login
end
```

### パスワード一致確認
コントローラ側
`@user =Users.find_by(email: param[:email], password[:password])`
Users.find_byで検索しデータあるなし検索

データあれば`redirect_to("次画面")`
でHTTPリクエスト
データなければ`render("")`でもう一回読み込み  

#### 一致しない時のエラーメッセージ設定および再表示の入力値再表示

コントローラ側
`@email = param[:email]`なんかで変数定義
`@errormasage = "エラーでっせ"`なんかで変数定義

view側
'<input name="email" value = "<%= @email%>">`
name="コントローラ側にparam渡す値設定"
<%= @email%>でコントローラ側で設定した値出力

<%= @error_message %>でコントローラ側で設定したエラーメッセージ設定


## ログイン処理

>「ログインフォームから送信されたメールアドレスとパスワードに一致するユーザー」が存在する場合は、そのユーザーのidを変数sessionに代入>し、ユーザーのブラウザに保存

controller側
変数sessionを使うことで値をセッション保存できる
`session[:user_id] = @user.id`

view側
`<%= session[:user_id] %>`で出力

## ログアウト処理
コントローラーでnull(nil)を代入することでセッション変数をリセットする

route.rb
`post "logout" => "users#logout"`

controller側
`session[:user_id] = nil`

#### ログイン状態による出力項目設定

view側
```
        <% if session[:user_id] %>
          <li>
            現在ログインしているユーザーのid:
            <%= session[:user_id] %>
          </li>
          ...
          <li>
             <%= link_to("ログアウト", "/logout", {method: :post}) %>           
          </li>
        <% else %>
           <li>
            <%= link_to("TweetAppとは", "/about") %>
          </li>
        <% end %>
```

**ユーザ新規作成時にパスワードをセッション保存するがよろし**





