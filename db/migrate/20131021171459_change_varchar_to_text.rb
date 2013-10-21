class ChangeVarcharToText < ActiveRecord::Migration
  def up
    change_column :content_rich_texts, :content, :text
  end

  def down
    change_column :content_rich_texts, :content, :string
  end
end
