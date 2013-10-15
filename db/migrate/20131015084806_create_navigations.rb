class CreateNavigations < ActiveRecord::Migration
  def change
    create_table :navigations do |t|
      t.string :name, null: false
      t.timestamps
    end

    add_belongs_to :nav_items, :navigation
    rename_table :nav_items, :navigation_items
  end

end
