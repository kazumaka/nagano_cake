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
    get "customers/my_page" => "customers#show",as: "customer"
    get "customers/registration_edit" => "customers#edit",as: "edit_customer"
    patch "customers/registration_edit" => "customers#update",as: "customers"
    get "customers/confirm" => "customers#confirm",as: "confirm"
    patch "customer/secession" => "customers#secession",as: "secession"
    resources :addresses,except:[:new, :show, :destroy]
    delete "addresses/:id" => "addresses#destroy",as: "destroy_address"
    resources :items,only:[:index, :show]
    delete "cart_items/destroy_all" => "cart_items#destroy_all",as: "destroy_all"
    resources :cart_items, only:[:index, :create, :update, :destroy]
    get "orders/thanks" => "orders#thanks",as: "thanks"
    resources :orders, only:[:new, :index, :show]
    post "orders/confirm" => "orders#confirm",as: "order_confirm"
    post "orders" => "orders#create",as: "create_orders"
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
