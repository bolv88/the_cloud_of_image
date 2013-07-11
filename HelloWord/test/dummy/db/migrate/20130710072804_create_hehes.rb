class CreateHehes < ActiveRecord::Migration
  def change
    create_table :hehes do |t|
      t.string :name

      t.timestamps
    end
  end
end
