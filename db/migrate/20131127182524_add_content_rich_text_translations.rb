class AddContentRichTextTranslations < ActiveRecord::Migration
  def up
    ContentRichText.create_translation_table!({:content => :text}, {
        :migrate_data => true
    })
  end

  def down
    ContentRichText.drop_translation_table!
  end
end
