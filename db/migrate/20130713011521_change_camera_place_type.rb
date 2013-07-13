class ChangeCameraPlaceType < ActiveRecord::Migration
  def up
    change_table(:cameras) do |t|
      t.remove :place
      t.integer :place_id
    end
  end

  def down
  end
end
