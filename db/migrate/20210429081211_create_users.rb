class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password

      t.timestamps
    end

    add_reference :tasks, :user, foreign_key: true
  end
end
