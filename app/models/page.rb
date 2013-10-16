class Page < ActiveRecord::Base
  has_many :page_contents
  has_many :content_types, through: :page_contents, source: :content_type, source_type: 'ContentRichText'

  rails_admin do
    navigation_label 'Content'
    weight -1
  end
end
