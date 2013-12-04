class Contact < ActiveRecord::Base

  validates_presence_of :email, :comment, :firstname, :lastname
end
