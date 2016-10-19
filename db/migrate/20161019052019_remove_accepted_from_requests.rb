class RemoveAcceptedFromRequests < ActiveRecord::Migration[5.0]
  def change
    remove_column :requests, :accepted
  end
end
