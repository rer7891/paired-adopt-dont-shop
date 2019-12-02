class ChangeImagetoImageUrl < ActiveRecord::Migration[5.1]
  def change
    rename_column :pets, :image, :image_url
  end
end
