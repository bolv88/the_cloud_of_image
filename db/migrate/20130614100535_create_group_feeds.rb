class CreateGroupFeeds < ActiveRecord::Migration
  def change
    create_table :group_feeds do |t|
      t.string :feed_type
      t.integer :user_id
      t.integer :group_id
      t.integer :status

      t.timestamps
    end
  end
end
