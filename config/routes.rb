DemoRenuoCh::Application.routes.draw do
  devise_for :users, :controllers => {:registrations => "registrations"}
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  mount Ckeditor::Engine => '/ckeditor'
  root :to => "home#index"
  resources :pages, only: [:show]
  resources :users
end