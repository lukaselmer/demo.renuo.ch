class ContentRichText < ActiveRecord::Base
  has_many :page_content, as: :content_type

  has_paper_trail

  rails_admin do
    navigation_label 'Content'

    edit do
      field :content, :ck_editor
    end

    configure :content do
      pretty_value do
        obj = bindings[:object]
        %{<div style="max-height: 100px; zoom: 0.5;">#{obj.content}</div>}.html_safe
      end
    end

    weight do
      -2
    end
  end
end
