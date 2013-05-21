class CreateConvertRules < ActiveRecord::Migration
  def change
    create_table :convert_rules do |t|
      t.integer :user_id
      t.string :title
      t.string :symbol, :limit=>64
      t.text :description
      t.string :status, :limit=>16

      t.timestamps
    end
  end
end
