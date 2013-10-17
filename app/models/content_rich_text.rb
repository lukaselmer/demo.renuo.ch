class ContentRichText < ActiveRecord::Base
  has_many :page_content, as: :content_type

  has_paper_trail

  rails_admin do
    navigation_label 'Inhalte'
    object_label_method :label
    weight -2

    edit do
      field :name
      field :content, :ck_editor
    end

    list do
      field :name
      field :content do
        pretty_value do
          obj = bindings[:object]
          %{<div style="max-height: 100px; zoom: 0.5;">#{obj.content}</div>}.html_safe
        end
      end
    end

  end

  def label
    name
  end
end
