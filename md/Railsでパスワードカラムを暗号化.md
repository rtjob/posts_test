### パスワード暗号化
railsで開発中にMongoDBのパスワードカラムとか
生で保存したくないデータを暗号化したいとき


例:
コレクション:User
カラム:password
追加

bcryptを追加

bcryptとは
---


####Gemfile編集

bcryptをまず追加する

'''
# パスワード暗号化Gem
gem 'bcrypt', '~> 3.1.11'
'''