class CreateCameras < ActiveRecord::Migration
  def change
    create_table :cameras do |t|
      t.integer :user_id
      t.string :image_url
      t.string :place

      t.timestamps
    end
  end
end
