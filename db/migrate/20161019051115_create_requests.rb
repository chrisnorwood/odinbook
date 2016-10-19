class CreateRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :requests do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.integer :friend_id, null: false

      t.integer :accepted, null: false, default: 0
      t.timestamps
    end
  end
end