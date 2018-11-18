###カラム追加したい
railsで開発中にMongoDBのカラムのみを追加したいとき

例:
コレクション:User
フィールド:email
追加

####コマンド叩く必要なし

model側に
```rb
class User
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :email, type: String


  # nameカラムに関するバリデーション
  validates :name,{presence: true, uniqueness: true}
  
  # emailカラムに関するバリデーション
  validates :email,{presence: true, uniqueness: true}

end
```

的な感じでフィールド追加すればよろし

例

コントローラ側
`@user = User.find_by(email: params[:email])`

view側
`<input class="mb-3" name = "email">`



###一応MongoDB以外の場合

MYSQLとか使用する場合
`rails generate migration クラス名`
コマンドで/db/migrate/
内にマイグレーションスクリプトファイルが作成され
```rb
class AddColumnTitles < ActiveRecord::Migration
  def up
  end

  def down
  end
end
``` 
のなかに  
```rb
class AddColumnTitles < ActiveRecord::Migration
  def up
    add_column :Users, :email, :string
  end

  def down
    remove_column :Users, :email, :string
  end
end
```
的な感じでカラム情報を渡してあげて
`rails db:migrate`か`rake db:migrate`
を叩けばよろし

それによりcontroller側で追加したカラムを使用できる