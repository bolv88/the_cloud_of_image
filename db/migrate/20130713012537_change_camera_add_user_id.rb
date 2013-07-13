class ChangeCameraAddUserId < ActiveRecord::Migration
  def up
    change_table(:camera_places) do|t|
      t.integer :user_id
    end
  end

  def down
  end
end
