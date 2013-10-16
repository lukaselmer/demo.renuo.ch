class CreateFooterNavigationItems < ActiveRecord::Migration
  def change
    create_table :footer_navigation_items do |t|
      t.references :page, null: true
      t.string :target

      t.timestamps
    end

    add_column :footer_navigation_items, :ancestry, :string
    add_column :footer_navigation_items, :order, :integer
    add_index :footer_navigation_items, :ancestry
    add_column :footer_navigation_items, :position, :integer
  end
end
