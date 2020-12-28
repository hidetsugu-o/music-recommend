# テーブル設計

## Usersテーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| nickname           | string | null: false, unique: true |

### Association

- has_many :posts
- has_many :likes
- has_many :comments

## Postsテーブル

| Column   | Type       | Options           |
| -------- | ---------- | ----------------- |
| title    | string     | null: false       |
| text     | text       |                   |
| link     | string     | null: false       |
| user     | references | foreign_key: true |

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

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| post   | references | null: false, foreign_key: true |
| tag    | references | null: false, foreign_key: true |

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