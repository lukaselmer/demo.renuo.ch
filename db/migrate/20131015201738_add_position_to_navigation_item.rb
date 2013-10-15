class AddPositionToNavigationItem < ActiveRecord::Migration
  def change
    add_column :navigation_items, :position, :integer
  end
end
