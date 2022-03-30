Rails.application.routes.draw do

  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
  }

  scope module: :public do
    root to: "homes#top"
    get "home/about" => "homes#about",as: "about"
  end
  

  namespace :admin do
    root to: "homes#top"
    resources :genres, only:[:index, :create, :edit, :update]
    resources :items, except:[:destroy]
    resources :customers ,only:[:index, :show, :edit, :update]
    resources :orders, only:[:show, :update]
    resources :order_details, only:[:update]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
