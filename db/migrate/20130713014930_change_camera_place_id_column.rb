class ChangeCameraPlaceIdColumn < ActiveRecord::Migration
  def up
    change_table(:cameras) do |t|
      t.remove :place_id
      t.integer :camera_place_id
    end
  end

  def down
  end
end
