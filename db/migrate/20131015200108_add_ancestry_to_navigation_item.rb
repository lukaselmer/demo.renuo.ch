class AddAncestryToNavigationItem < ActiveRecord::Migration
  def change
    add_column :navigation_items, :ancestry, :string
    add_column :navigation_items, :order, :integer
    add_index :navigation_items, :ancestry
  end
end


