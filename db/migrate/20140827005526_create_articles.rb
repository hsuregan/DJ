class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :author
      t.string :email
      t.text :content
      t.integer :rating
      t.integer :artist_id
      t.integer :album_id
      t.boolean :approval
      t.timestamps
    end
  end
end
