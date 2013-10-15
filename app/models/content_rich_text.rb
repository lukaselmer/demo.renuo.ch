class ContentRichText < ActiveRecord::Base
  has_many :page_content, as: :content_type

  rails_admin do
    edit do
      field :content, :ck_editor
    end
  end
end
