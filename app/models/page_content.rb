class PageContent < ActiveRecord::Base
  belongs_to :page
  belongs_to :content_type, polymorphic: true
end
