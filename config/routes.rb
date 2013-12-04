DemoRenuoCh::Application.routes.draw do
  devise_for :users, :controllers => {:registrations => "registrations"}
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  mount Ckeditor::Engine => '/ckeditor'

  # remove block if not multi lingual
  scope "(:locale)", :locale => /en|de/ do
    root :to => "home#index"
    resources :pages, only: [:show]
    resources :contacts, only: [:index, :create]
  end

end