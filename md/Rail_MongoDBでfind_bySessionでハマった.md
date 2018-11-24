### 
Railsにてfind_by(:id session[:id])で
Mongo::Error::OperationFailure in PostsController#show
unknown operator: $oid (2)

が出た


```erb
   def setCurrentUser
        if session[:user_id]
            @current_user = User.find_by(id: session[:user_id]) 
        end

    end
```

### 回避法

idで検索する際はfind_byではなくfindで検索する方がいい
ただしfindはカラムがidのみでしか検索できないので注意
```erb
    def setCurrentUser
        if session[:user_id]
            @current_user = User.find(session[:user_id]) 
        end

    end
```


どうもMongoDBとRailsは相性があまり良くないらしい

