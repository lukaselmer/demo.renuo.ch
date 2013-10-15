class ContentRichText < ActiveRecord::Base
  has_many :page_content, as: :content_type
end
