Pplugin::Application.routes.draw do

  resource :session, :only => [:new, :create, :destroy]

  match 'login' => 'openids#pixnet', :as => :login

  match 'logout' => 'openids#logout', :as => :logout

  match '/info' => 'account#info', :as => :info

  root :to => "home#index"

  resource :openid do
    get "pixnet", :on => :member
  end 

  resources :oauth_consumers do
    get "callback", :on => :member
  end

  resource :akismet

  resources :pshbs do # PubSubHubbub
    get "akismet", :on => :member
    post "akismet", :on => :member
  end

end
