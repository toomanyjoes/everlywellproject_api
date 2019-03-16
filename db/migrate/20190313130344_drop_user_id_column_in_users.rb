class DropUserIdColumnInUsers < ActiveRecord::Migration[5.2]
  def up
    remove_column :users, :user_id
  end

  def down
    add_column :users, :user_id, :integer
  end
end
