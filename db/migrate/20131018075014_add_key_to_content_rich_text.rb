class AddKeyToContentRichText < ActiveRecord::Migration
  def change
    add_column :content_rich_texts, :key, :string, null: true, default: ''
    add_index :content_rich_texts, :key
  end
end
