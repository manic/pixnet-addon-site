[core]
    使用者經由 PIXNET OpenID 登入此站

[Oauth]
    使用者經由 PIXNET OAuth (1.0a) 與 PIXNET 溝通。

[Akimet]
    使用者經由 Google PSHBS HUB 來訂閱使用者自己的 Comment.
    當有了新的 Comment 會經由 PSHBS push 到這裡
    接到 comment 後要推到 akismet 做判斷是否為廣告留言。
    是的話要經由 PIXNET OAuth 來將 Comment 指定為廣告留言。

    - 使用者需要輸入 Akismet 的 API Key 來啟用服務。
    - 使用者可以"啟用/關閉"服務。
    - 使用者必須先啟用 PIXNET OAuth 才可以使用此服務。