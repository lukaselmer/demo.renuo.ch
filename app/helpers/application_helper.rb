module ApplicationHelper

  def display_base_errors resource
    return '' if (resource.errors.empty?) or (resource.errors[:base].empty?)
    messages = resource.errors[:base].map { |msg| content_tag(:p, msg) }.join
    html = <<-HTML
    <div class="alert alert-error alert-block">
      <button type="button" class="close" data-dismiss="alert">&#215;</button>
      #{messages}
    </div>
    HTML
    html.html_safe
  end


  def update_url(record)
    #force rails_admin to return_to after successful update (path/url helpers did not recognize ssl!)
    port = [80, 443].include?(request.port) ? '' : ":#{request.port}"
    ssl_suffix = Figaro.env.use_ssl == '1' ? 's' : ''
    return_to = "http#{ssl_suffix}://#{request.host}#{port}#{root_path}"
    rails_admin.edit_path(model_name: record.class.model_name.singular, id: record.to_param, locale: nil, return_to: return_to)
  end

  def content_rich_text_fields(record)
    translated = ContentRichText.translated? 'content'
    translations_form_name = translated ? '[translations_attributes][0]' : ''
    field_name_prefix = "#{record.class.model_name.singular}#{translations_form_name}"

    fields = [
        {name: 'content', value: ''}
    ]

    if translated
      fields << {name: 'locale', value: I18n.locale}
      fields << {name: 'id', value: record.translation.to_param}
    end

    {
        field_name_prefix: field_name_prefix,
        fields: fields
    }
  end


  def active_nav_item
    return @active_nav_item if @active_nav_item
    url_path = request.path
    page = page_by_path(url_path)
    items = []
    [NavigationItem, FooterNavigationItem].each do |item_class|
      items.concat(item_class.all.select do |item|
        # manually typed target wins over chosen page
        (item.localized_target(I18n.locale) == url_path || (page.present? && item.page_id.to_s == page.to_param))
      end)
    end
    # items.count.should eq 1
    @active_nav_item = items.first # cache active_nav_item per request
  end

  def page_by_path(url)
    Page.select do |p|
      path = url_for(p)
      path == url
    end.first
  end

  def is_nav_item_active ni
    return if active_nav_item.nil?
    ni.id == active_nav_item.id || active_nav_item.path_ids.include?(ni.id)
  end

  def subnav_items
    active_nav_item.parent ? active_nav_item.siblings : active_nav_item.children
  end

  def subnav_visible?
    active_nav_item && (active_nav_item.has_children? || active_nav_item.parent)
  end
end
