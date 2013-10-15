class CreateNavItems < ActiveRecord::Migration
  def change
    create_table :nav_items do |t|

      t.references :page, null: true
      t.string :target

      t.timestamps
    end
  end
end
