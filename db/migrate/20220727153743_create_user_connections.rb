class CreateUserConnections < ActiveRecord::Migration[7.0]
  def change
    create_table :user_connections do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :user_pair, null: false, foreign_key: true

      t.timestamps
    end
  end
end
