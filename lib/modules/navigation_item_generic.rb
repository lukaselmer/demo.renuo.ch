module NavigationItemGeneric

  def self.included model

    model.belongs_to :page
    model.has_ancestry

    model.validates_presence_of :title
    model.validates_presence_of :page, if: -> {target.blank?}
    model.validates_presence_of :target, if: -> {page.blank?}

    model.rails_admin do
      object_label_method :label

      edit do
        field :title
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
