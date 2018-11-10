class CreateFollowers < ActiveRecord::Migration[5.2]
  def change
    create_table :followers do |t|
      t.references :user, allow_null: false, foreign_key: true
      t.references :follower, allow_null: false, foreign_key: { to_table: :users }
    end

    add_index :followers, [:user_id, :follower_id], unique: true
    execute 'ALTER TABLE followers ADD CONSTRAINT user_id_cannot_be_equal_follower_id_check CHECK (user_id <> follower_id);'
  end
end
