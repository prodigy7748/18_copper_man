class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :content
      t.datetime :start_time
      t.datetime :end_time
      t.integer :priority
      t.integer :status

      t.timestamps
    end
  end
end
