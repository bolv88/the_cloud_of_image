class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.integer :user_id
      t.string :title
      t.string :file_id, :limit=>64
      t.decimal :file_size
      t.integer :width
      t.integer :height
      t.string :format, :limit=>8

      t.timestamps
    end
  end
end
