class AddNameToContentRichText < ActiveRecord::Migration
  def change
    add_column :content_rich_texts, :name, :string, null: false, default: ''
  end
end
