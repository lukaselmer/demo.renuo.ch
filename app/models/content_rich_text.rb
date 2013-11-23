class ContentRichText < ActiveRecord::Base
  has_many :page_content, as: :content_type

  has_paper_trail

  validates_presence_of :name, :content
  validates_uniqueness_of :key, if: 'key.present?'

  scope :predefined, -> (key) {
    ContentRichText.where(key: key).first
  }

  rails_admin do
    parent Page
    object_label_method :instance_label

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

    show do
      field :content do
        pretty_value do
          value.html_safe
        end
      end
    end

  end

  def instance_label
    name
  end

end
