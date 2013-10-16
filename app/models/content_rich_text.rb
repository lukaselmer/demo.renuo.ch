class ContentRichText < ActiveRecord::Base
  has_many :page_content, as: :content_type

  has_paper_trail

  rails_admin do
    navigation_label 'Content'

    edit do
      field :content, :ck_editor
    end
  end
end
