class RenameLikableToLikeable < ActiveRecord::Migration[5.0]
  def change
    rename_column :likes, :likable_id,   :likeable_id
    rename_column :likes, :likable_type, :likeable_type
  end
end
