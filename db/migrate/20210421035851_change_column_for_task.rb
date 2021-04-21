class ChangeColumnForTask < ActiveRecord::Migration[6.1]
  def change
    change_column :tasks, :title, :string, null: false, unique: true
    change_column :tasks, :content, :text, null: false
  end
end
