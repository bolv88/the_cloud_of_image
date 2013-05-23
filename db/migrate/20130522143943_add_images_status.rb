class AddImagesStatus < ActiveRecord::Migration
  def up
    add_column :images, :status, :integer, default: 1
  end

  def down
  end
end
