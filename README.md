# テーブル設計

## Usersテーブル

| Column             | Type   | Options                        |
| ------------------ | ------ | ------------------------------ |
| user_id            | string | null: false, primary_key: true |
| name               | string | null: false                    |
| icon               | string |                                |
| message            | string |                                |
| encrypted_password | string | null: false                    |

### Association

- has_many :posts
- has_many :likes
- has_many :liked_posts, through :likes, source :post

## Postsテーブル

| Column   | Type   | Options           |
| -------- | ------ | ----------------- |
| video_id | string | null: false       |
| user_id  | string | foreign_key: true |

### Association

- belongs_to :user, primary_key :user_id
- has_many :likes
- has_many :liked_users, through :likes, source :post

## Likesテーブル

| Column | Type       | Options           |
| ------ | ---------- | ----------------- |
| user   | references | foreign_key: true |
| post   | references | foreign_key: true |

### Association

- belongs_to :user
- belongs_to :post