class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts, options: 'ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci'  do |t|

      t.string :title,        limit: 200, null: false, unique: true
      t.string :description,  limit:255,  null: false, unique: true
      t.text :content,        null: false, unique: true
      t.string :thumbnail,    limit: 100, default: 'avatar.png'
      t.integer :user_id,     limit: 4,   null: false
      t.boolean :status,      default: 0

      t.timestamps null: false
    end
  end
end
