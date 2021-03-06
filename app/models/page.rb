class Page < ActiveRecord::Base
  has_many :page_contents
  has_many :content_types, through: :page_contents, source: :content_type, source_type: 'ContentRichText'

  validates_presence_of :title
  validates_uniqueness_of :key, if: "key.present?"

  scope :predefined, -> (key) {
    Page.where(key: key).first
  }

  rails_admin do
    navigation_label 'Inhalte'
    weight -4

    edit do
      field :title
      field :content_types
    end

    list do
      field :title
      field :content_types
      field :updated_at
    end

  end

end
