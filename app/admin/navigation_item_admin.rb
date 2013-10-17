module NavigationItemAdmin

  def self.included model
    model.rails_admin do
      object_label_method :label
      edit do
        field :title do
          help do
            i18n_help_lookup(self)
          end
        end
        field :page do
          help do
            i18n_help_lookup(self)
          end
        end
        field :target do
          help do
            i18n_help_lookup(self)
          end
        end
      end

      list do
        field :title
        field :page
        field :target
      end

      default_action do
        :nestable
      end

      weight -1

      nestable_tree({
                        max_depth: 1,
                        position_field: :position
                    })
    end
  end
end
