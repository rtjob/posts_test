### 全ページ共通のヘッダーフッターだす
全ページにわたり共通のヘッダーフッター出したい場合は、  
簡易的なWebアプリで結構あると思う  

やり方は結論から言うと
views/layouts/application.html.erb  
にヘッダーフッター書くと、全ページにわたり共通のコンテンツが出力される

例
```erb
<!DOCTYPE html>
<html>
  <head>
    <title>PostsTest</title>
    <%= csrf_meta_tags %>
    <%= csp_meta_tag %>

    <%= stylesheet_link_tag    'application', media: 'all', 'data-turbolinks-track': 'reload' %>
    <%= javascript_include_tag 'application', 'data-turbolinks-track': 'reload' %>
  </head>

  <body>
   <header>
    <!-- <div class="container">
      <div class="header-left">
    -->
    </header>

    <%= yield %>

    <footer class="text-center text-muted py-4">
      Copyright OOO
    </footer>
  </body>
</html>
```

的な感じheadタグやらheaderタグ、footerタグ書くがよろし

### カテゴリ別で共通コンテンツを出したい場合

共通で出したいコンテンツ以外に、カテゴリ別で出したいコンテンツがある場合

フォルダ切って、その中でerbファイル作るがよろし
ただし、_footer.html.erbなど
_をつける

erbで使いたいときは
`<%= render 'hoge' %>`

例
- view/user

-- _footer.html.erbで定義
```_footer.html.erb
<footer class="text-center text-muted py-4">
  Copyright OOO
</footer>
```

-- 同フォルダ内　index.html.erb　で呼び出し
```index.html.erb
#
# なんか処理
#
<%= render 'footer' %>
```

-- view/post/index.html.erb　で呼び出し
```index.html.erb
#
# なんか処理
#
<%= render 'posts/footer' %>
```
