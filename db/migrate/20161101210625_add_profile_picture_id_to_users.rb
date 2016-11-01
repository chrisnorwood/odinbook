class AddProfilePictureIdToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :profile_picture_id, :integer, default: nil
  end
end
