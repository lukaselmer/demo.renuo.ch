# RailsAdmin config file. Generated on October 15, 2013 09:26
# See github.com/sferik/rails_admin for more informations

# start navigation_action
module RailsAdmin
  module Config
    Model.class_eval do
      register_instance_option :navigation_action do
        :index
      end
    end
  end

  ApplicationHelper.class_eval do
    def navigation nodes_stack, nodes, level=0
      nodes.map do |node|
        model_param = node.abstract_model.to_param
        # the only thing changed here is the next lines action => value
        url = url_for(:action => node.navigation_action, :controller => 'rails_admin/main', :model_name => model_param)
        level_class = " nav-level-#{level}" if level > 0
        nav_icon = node.navigation_icon ? %{<i class="#{node.navigation_icon}"></i>}.html_safe : ''

        li = content_tag :li, "data-model" => model_param do
          link_to nav_icon + node.label_plural, url, :class => "pjax#{level_class}"
        end
        li + navigation(nodes_stack, nodes_stack.select { |n| n.parent.to_s == node.abstract_model.model_name }, level+1)
      end.join.html_safe
    end
  end
end
# end navigation_action

# start i18n
module RailsAdmin
  module Config
    module Fields
      module Types
        Base.class_eval do
          alias :org_help :help
          register_instance_option :help do
            generic_i18n_help_lookup
          end

          def generic_i18n_help_lookup
            model = self.abstract_model.model_name.underscore
            model_lookup = "admin.help.#{model}.#{name}".to_sym
            field_lookup = "admin.help.#{name}".to_sym
            I18n.t(model_lookup, default: [field_lookup, org_help]).html_safe
          end
        end
        String.class_eval do
          alias :org_help :help
          register_instance_option :help do
             generic_i18n_help_lookup
          end
        end
        # other field types do not override help or overrides do not use i18n
      end
    end
  end
end
# end i18n

RailsAdmin.config do |config|


  ################  Global configuration  ################

  # Set the admin name here (optional second array element will appear in red). For example:
  config.main_app_name = ['Renuo CMS', 'Demo']
  # or for a more dynamic name:
  # config.main_app_name = Proc.new { |controller| [Rails.application.engine_name.titleize, controller.params['action'].titleize] }

  # RailsAdmin may need a way to know who the current user is]
  config.current_user_method { current_user } # auto-generated

  # If you want to track changes on your models:
  # config.audit_with :history, 'User'

  # Or with a PaperTrail: (you need to install it first)
  config.audit_with :paper_trail, 'User'
  config.authorize_with :cancan

  # Display empty fields in show views:
  # config.compact_show_view = false

  # Number of default rows per-page:
  # config.default_items_per_page = 20

  # Exclude specific models (keep the others):
  # config.excluded_models = ['Role', 'User']

  # Include specific models (exclude the others):
  config.included_models = [Role, User, Page, ContentRichText, NavigationItem, FooterNavigationItem, Ckeditor::AttachmentFile, Ckeditor::Picture]

  # Label methods for model instances:
  # config.label_methods << :description # Default is [:name, :title]


  ################  Model configuration  ################

  # Each model configuration can alternatively:
  #   - stay here in a `config.model 'ModelName' do ... end` block
  #   - go in the model definition file in a `rails_admin do ... end` block

  # This is your choice to make:
  #   - This initializer is loaded once at startup (modifications will show up when restarting the application) but all RailsAdmin configuration would stay in one place.
  #   - Models are reloaded at each request in development mode (when modified), which may smooth your RailsAdmin development workflow.


  # Now you probably need to tour the wiki a bit: https://github.com/sferik/rails_admin/wiki
  # Anyway, here is how RailsAdmin saw your application's models when you ran the initializer:


  ###  Role  ###

  # config.model 'Role' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your role.rb model definition

  #   # Found associations:

  #     configure :resource, :polymorphic_association         # Hidden
  #     configure :users, :has_and_belongs_to_many_association

  #   # Found columns:

  #     configure :id, :integer
  #     configure :name, :string
  #     configure :resource_id, :integer         # Hidden
  #     configure :resource_type, :string         # Hidden
  #     configure :created_at, :datetime
  #     configure :updated_at, :datetime

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  User  ###

  # config.model 'User' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your user.rb model definition

  #   # Found associations:

  #     configure :invited_by, :polymorphic_association         # Hidden
  #     configure :roles, :has_and_belongs_to_many_association

  #   # Found columns:

  #     configure :id, :integer
  #     configure :email, :string
  #     configure :password, :password         # Hidden
  #     configure :password_confirmation, :password         # Hidden
  #     configure :reset_password_token, :string         # Hidden
  #     configure :reset_password_sent_at, :datetime
  #     configure :remember_created_at, :datetime
  #     configure :sign_in_count, :integer
  #     configure :current_sign_in_at, :datetime
  #     configure :last_sign_in_at, :datetime
  #     configure :current_sign_in_ip, :string
  #     configure :last_sign_in_ip, :string
  #     configure :created_at, :datetime
  #     configure :updated_at, :datetime
  #     configure :name, :string
  #     configure :confirmation_token, :string
  #     configure :confirmed_at, :datetime
  #     configure :confirmation_sent_at, :datetime
  #     configure :unconfirmed_email, :string
  #     configure :invitation_token, :string
  #     configure :invitation_created_at, :datetime
  #     configure :invitation_sent_at, :datetime
  #     configure :invitation_accepted_at, :datetime
  #     configure :invitation_limit, :integer
  #     configure :invited_by_id, :integer         # Hidden
  #     configure :invited_by_type, :string         # Hidden

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end

  config.model 'Ckeditor::Picture' do
    navigation_label 'Dateiverwaltung'
    weight -2
  end
  config.model 'Ckeditor::AttachmentFile' do
    navigation_label 'Dateiverwaltung'
  end

  config.actions do
    # root actions
    dashboard # mandatory
              # collection actions
    index
    new
              #export
              #history_index
    bulk_delete
              # member actions
    show
    edit do
      #visible false
    end
    delete
              #history_show
              #show_in_app
    nestable
  end

end
