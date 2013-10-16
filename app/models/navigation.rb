class Navigation < ActiveRecord::Base
  has_many :navigation_items

  rails_admin do
    navigation_label 'Content'
  end
end
