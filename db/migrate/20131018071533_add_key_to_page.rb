class AddKeyToPage < ActiveRecord::Migration
  def change
    add_column :pages, :key, :string, null: true, default: ''
    add_index :pages, :key
  end
end
