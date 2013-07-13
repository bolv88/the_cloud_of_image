class CreateCameraPlaces < ActiveRecord::Migration
  def change
    create_table :camera_places do |t|
      t.string :place
      t.integer :status

      t.timestamps
    end
  end
end
