class RenameProfilePicturesId < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :profile_picture_id, :profile_photo_id
  end
end
