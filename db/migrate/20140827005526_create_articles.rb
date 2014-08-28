class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :content
      t.integer :rating
      t.integer :year
      t.integer :artist_id
      t.integer :album_id
      t.timestamps
    end
  end
end
