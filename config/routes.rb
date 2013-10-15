DemoRenuoCh::Application.routes.draw do
  devise_for :users, :controllers => {:registrations => "registrations"}
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  root :to => "home#index"
  resources :pages, only: [:show]

  # generate paths that are available in cms link chooser
  # (maybe: use cancan for authorization OR show all, auth happens on request)
  scope path: '_' do
    resources :users
  end

end