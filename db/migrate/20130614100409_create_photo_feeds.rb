class CreatePhotoFeeds < ActiveRecord::Migration
  def change
    create_table :photo_feeds do |t|
      t.integer :group_id
      t.integer :user_id
      t.integer :photo_id
      t.integer :status

      t.timestamps
    end
  end
end
