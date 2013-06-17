class AddCreateIdToGroupFeeds < ActiveRecord::Migration
  def change
    add_column :group_feeds, :create_id, :integer
  end
end
