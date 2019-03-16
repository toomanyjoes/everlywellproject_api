class CreateUserdata < ActiveRecord::Migration[5.2]
  def change
    create_table :userdata do |t|
      t.integer :user_id
      t.string :data_type
      t.string :data

      t.timestamps
    end
  end
end
