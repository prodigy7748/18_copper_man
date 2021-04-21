- Ruby version : 2.7.2
- Rails version : 6.1.3.1

### 任務功能

- 可新增自己的任務
- 使用者登入後，只能看見自己建立的任務
- 可設定任務的開始及結束時間
- 可設定任務的優先順序（高、中、低）
- 可設定任務目前的狀態（待處理、進行中、已完成）
- 可依狀態篩選任務
- 可以任務的標題、內容進行搜尋
- 可為任務加上分類標籤
- 任務列表，並可依優先順序、開始時間及結束時間等進行排序

### ERD

![image](https://github.com/prodigy7748/task_manage_system/blob/master/img/ERD.png)

### Deploy the app to Heroku

1. login with Heroku account
2. Download & install Heroku CLI（MacOS user can use Homebrew command: brew install heroku/brew/heroku)
3. $ heroku login
4. Run $ heroku create
5. Run $ git push heroku master or run $ git push heroku (your branch name):master to push another branch
6. Run $ heroku run rails db:migrate if this is your first time pushing code
7. https://warm-spire-63971.herokuapp.com/
