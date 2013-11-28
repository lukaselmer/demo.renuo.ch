module NavigationItemGeneric

  def self.included model

    model.belongs_to :page
    model.has_ancestry

    model.translates :title
    model.accepts_nested_attributes_for :translations, :allow_destroy => true

    model.validates_presence_of :title
    model.validates_presence_of :page, if: -> {target.blank?}
    model.validates_presence_of :target, if: -> {page.blank?}

    model.scope :flat, ->  {
      model.order(:position)
    }

    # / => /de/
    # /de/contacts => /de/contacts
    # /contacts => /de/contacts
    # contacts => contacts
    # http://www.google.com => http://www.google.com
    def localized_target(locale)
      t = target
      is_l10n_app = I18n.available_locales.count > 1
      if is_l10n_app && t.start_with?('/') && t[2] != '/' && I18n.available_locales.exclude?(t[1..2].to_sym)
        t = "/#{locale}#{t}"
      end
      t
    end

    model.rails_admin do
      object_label_method :label

      edit do
        field :translations do
          # prevent help text below tab pane
          help false
        end
        field :page
        field :target
      end

      list do
        field :title
        field :page
        field :target
      end

      navigation_action do
        :nestable
      end

      weight -3

      nestable_tree({
                        max_depth: 1,
                        position_field: :position
                    })
    end

    def label
      title
    end

  end
end
