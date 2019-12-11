class AddimageToreviews < ActiveRecord::Migration[5.1]
  def change
    remove_column :reviews, :image_url
    add_column :reviews, :image_url, :string, default: "https://naturewatch.org/files/uploads/o-ANIMAL-SHELTER-facebook.jpg"
  end
end
