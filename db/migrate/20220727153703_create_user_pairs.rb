class CreateUserPairs < ActiveRecord::Migration[7.0]
  def change
    create_table :user_pairs do |t|
      t.boolean :friend
      t.integer :user1_id
      t.integer :user2_id

      t.timestamps
    end
  end
end
