class AddNameToPage < ActiveRecord::Migration
  def change
    add_column :pages, :name, :string, null: true, default: ''
    add_index :pages, :name
  end
end
