class CreateConcertReviews < ActiveRecord::Migration
  def change
    create_table :concert_reviews do |t|
      t.string :title
      t.string :location
      t.string :author
      t.string :email
      t.string :image
      t.boolean :approval
      t.integer :artist_id
      t.text :content

      t.timestamps
    end
  end
end
