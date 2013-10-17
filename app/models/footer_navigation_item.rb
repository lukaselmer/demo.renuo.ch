class FooterNavigationItem < ActiveRecord::Base

  belongs_to :page
  validates_presence_of :title

  has_ancestry

  include NavigationItemAdmin

  def label
    #return self.class.model_name.human if new_record?
    #return page.title if page
    title
  end

end
