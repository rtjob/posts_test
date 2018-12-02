パスワードカラム暗号化

### Gemfile
# パスワード暗号化Gem
gemfile
gem 'bcrypt'


bundle install

###model

```user.rb
class User

  include ActiveModel::SecurePassword

  field :password_digest, type: String

  # has_secure_password_パスワード暗号化
  has_secure_password
```

###password保存

Rails側はUser.passwordに保存することで
自動でpassword_digestカラムに保存する


###authenticate
has_secure_passwordメソッドを有効にすると、authenticateメソッドを使えるようになります。
authenticateメソッドは渡された引数を暗号化し、password_digestの値と一致するかどうかを判定
```
@user.authenticate(params[:password])
```


### has_secure_password追加時にエラーが起きる場合
####NameError undefined local variable or method `has_secure_password'
NameError: undefined local variable or method
undefined local variable or method `has_secure_password'

で落ちる場合

```user.rb
  # has_secure_password_パスワード暗号化
  has_secure_password
```
を追加するだけでは落ちるっぽい

`include ActiveModel::SecurePassword`
を追加するがよろし

```user.rb
  include ActiveModel::SecurePassword
  ・・・
  field :Hoge, type: String
  ・・・
  # has_secure_password_パスワード暗号化
  has_secure_password
```
###LoadError cannot load such file -- bcrypt
gem bcryptをbundle installした後に
cannot load such file -- bcrypt
で落ちる場合

rails server を立ち上げ直すと直るっぽい
[「 cannot load such file -- bcryptというエラーに対する解決策」　Railsメモ③](http://tusukuru.hatenablog.com/entry/2016/08/24/160059)
