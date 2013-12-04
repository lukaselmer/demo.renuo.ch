class ContactsController < ApplicationController
  def index
    @contact = Contact.new
  end

  def create

    @contact = Contact.new(contact_params)

    if @contact.save
      redirect_to contacts_url, notice: t('.confirm_contact_request')
    else
      render 'index'
    end
  end

  private
  def contact_params
    params.require(:contact).permit(:email, :comment, :firstname, :lastname)
  end
end
