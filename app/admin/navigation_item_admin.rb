module NavigationItemAdmin

  def self.included model
    model.rails_admin do
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
  end


end
