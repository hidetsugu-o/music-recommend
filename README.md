# テーブル設計

## Usersテーブル

| Column             | Type   | Options                        |
| ------------------ | ------ | ------------------------------ |
| user_id            | string | null: false, primary_key: true |
| user_name          | string | null: false                    |
| user_icon          | string |                                |
| user_message       | string |                                |
| encrypted_password | string | null: false                    |

### Association

- has_many :posts
- has_many :likes
- has_many :comments

## Postsテーブル

| Column   | Type       | Options           |
| -------- | ---------- | ----------------- |
| video_id | string     | null: false       |
| user_id  | string     | foreign_key: true |

### Association

- belongs_to :user
- has_many :likes
- has_many :comments
- has_many :post_tag_relations
- has_many :tags, through :post_tag_relations

## Likesテーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| post   | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :post

## Commentsテーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| comment | text       | null: false                    |
| user    | references | null: false, foreign_key: true |
| post    | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :post

## Post_tag_relationsテーブル

| Column | Type   | Options                        |
| ------ | ------ | ------------------------------ |
| post   | string | null: false, foreign_key: true |
| tag    | string | null: false, foreign_key: true |

### Association

- belongs_to :post
- belongs_to :tag

## Tagsテーブル

| Column | Type   | Options                   |
| ------ | ------ | ------------------------- |
| genre  | string | null: false, unique: true |

### Association

- has_many :post_tag_relations
- has_many :posts, through :post_tag_relations