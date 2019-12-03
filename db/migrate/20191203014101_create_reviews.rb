class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.string :title
      t.integer :rating
      t.text :content
      t.string :image_url

      t.timestamps
    end
  end
end