
class NavigationItem < ActiveRecord::Base
  belongs_to :page
  belongs_to :navigation

  has_ancestry

  rails_admin do
    object_label_method :label
    edit do
      field :navigation
      field :page
      field :target, :enum do
        enum do
          NavigationItem::choosable_link_options
        end
      end
    end

    parent Navigation

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

  # [I18n.t('route.user.new'),url_for(controller: 'news', action: 'new')] => <a href="users/new">Neuen Benutzer anlegen</a>
  # [I18n.t('route.news.latest'),url_for(controller: 'news', action: 'latest')]
  # TODO was wenn argumente benötigt werden? wie kann user diese eingeben? wie z.b. bei show ...
  # [I18n.t('route.news.show'),url_for(controller: 'news', action: 'show', id: '??')]
  def self.choosable_link_options
    Rails.application.routes.routes.map do |route|
      #{name: route.name, path: route.path.spec.to_s, controller: route.defaults[:controller], action: route.defaults[:action], method: route.constraints[:request_method]}

      action = route.defaults[:action]
      controller = route.defaults[:controller]
      path = route.path.spec.to_s
      method = route.constraints[:request_method]
      [action, controller, path]

      if path[/\/_\//] && "#{method}"[/GET/]

        controller_names = controller.split('/')
        label = I18n.translate("route.#{controller_names.join('_')}.#{action}")
        # maybe use postgresql json data type :p ?
        value = "/#{controller}##{action}"
        [label, value]
      end

    end.compact
  end

end
