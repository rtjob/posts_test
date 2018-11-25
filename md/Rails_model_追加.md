### Railsモデル追加時コマンド

-

-rails g model追加
`rails g model Like user_id:string post_id:string`

>Running via Spring preloader in process 20423
      invoke  mongoid
      create    app/models/like.rb
      invoke    test_unit
      create      test/models/like_test.rb
      create      test/fixtures/likes.yml


/models/
like.rb自動追加
```
class Like
  include Mongoid::Document
  field :user_id, type: String
  field :post_id, type: String
end

```

- マイグレーションファイル反映
`rails db:migrate`

- バリデーション追加
-- nil禁止
presence:trueにする

```rb
  # user_idカラムに関するバリデーション
  validates :user_id,{presence: true}
```


-- uniqueにする
uniqueness: true

```rb
  # idカラムに関するバリデーション
  validates :id,{uniqueness: true}
```

-- ついで両方
カンマ区切りでっせ

```rb
  # idカラムに関するバリデーション
  validates :id,{presence: true, uniqueness: true}
```
