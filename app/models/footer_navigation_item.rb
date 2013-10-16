class FooterNavigationItem < ActiveRecord::Base

  belongs_to :page

  has_ancestry

  include NavigationItemAdmin

  def label
    return self.class.model_name.human if new_record?
    return page.title if page
    controller, action = target.split('#')
    I18n.t("nav.#{controller.split('/')[1..-1].join('_')}.#{action}")
  end
end
