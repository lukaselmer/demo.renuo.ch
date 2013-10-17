class AddTitleToNavigationItem < ActiveRecord::Migration
  def change

    add_column :navigation_items, :title, :string, null: false, default: ''
    add_column :footer_navigation_items, :title, :string, null: false, default: ''
  end
end
