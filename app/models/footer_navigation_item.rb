class FooterNavigationItem < ActiveRecord::Base

  belongs_to :page

  has_ancestry

  rails_admin do
    object_label_method :label
    edit do
      field :page
      field :target, :enum do
        enum do
          NavigationItem::choosable_link_options
        end
      end
    end

    parent 'Navigation'

    nestable_tree({
                      max_depth: 2,
                      position_field: :position
                  })
  end

  def label
    return self.class.model_name.human if new_record?
    return page.title if page
    controller, action = target.split('#')
    I18n.t("nav.#{controller.split('/')[1..-1].join('_')}.#{action}")
  end
end
