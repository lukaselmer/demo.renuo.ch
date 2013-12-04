class Contact < ActiveRecord::Base

  validates_presence_of :email, :comment, :firstname, :lastname

  rails_admin do
    navigation_label 'Inhalte'
    object_label_method :instance_label

    list do
      field :firstname
      field :lastname
      field :email
      field :comment do
        pretty_value do
          bindings[:view].simple_format(value)
        end
      end
    end

    show do
      field :firstname
      field :lastname
      field :email
      field :comment do
        pretty_value do
          bindings[:view].simple_format(value)
        end
      end
    end

  end

  def instance_label
    "#{firstname}, #{lastname}"
  end

end
