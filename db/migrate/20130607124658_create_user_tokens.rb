class CreateUserTokens < ActiveRecord::Migration
  def change
    create_table :user_tokens do |t|
      t.string :token
      t.string :machine_id
      t.integer :user_id

      t.timestamps
    end
  end
end
