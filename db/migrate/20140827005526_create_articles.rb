class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :content
      t.string :artist
      t.string :album
      t.integer :rating
      t.integer :year

      t.timestamps
    end
  end
end
