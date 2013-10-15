class CreateContents < ActiveRecord::Migration
  def change

    create_table(:content_rich_texts) do |t|
       t.string :content
    end

    create_table(:page_contents) do |t|

      t.references :content_type, polymorphic: true
      t.references :page

      t.timestamps
    end

  end
end
