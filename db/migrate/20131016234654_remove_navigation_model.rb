class RemoveNavigationModel < ActiveRecord::Migration
  def change
    drop_table :navigations
    remove_belongs_to :navigation_items, :navigation
  end
end
