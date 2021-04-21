class CAddDefaultForTaskColumns < ActiveRecord::Migration[6.1]
  def change
    change_column :tasks, :priority, :integer, using:'priority::integer', default: 0
    change_column :tasks, :status, :integer, using:'status::integer', default: 0
  end
end
