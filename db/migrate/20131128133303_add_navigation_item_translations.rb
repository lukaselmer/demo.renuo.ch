class AddNavigationItemTranslations < ActiveRecord::Migration
  def up
    FooterNavigationItem.create_translation_table!({:title => :string}, {
        :migrate_data => true
    })

    NavigationItem.create_translation_table!({:title => :string}, {
        :migrate_data => true
    })
  end

  def down
    FooterNavigationItem.drop_translation_table!

    NavigationItem.drop_translation_table!
  end
end
