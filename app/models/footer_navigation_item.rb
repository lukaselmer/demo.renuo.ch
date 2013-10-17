class FooterNavigationItem < ActiveRecord::Base

  belongs_to :page
  validates_presence_of :title

  has_ancestry

  include NavigationItemAdmin

  def label
    title
  end

end
