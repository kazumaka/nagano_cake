Rails.application.routes.draw do
  namespace :admin do
    get 'items/index'
    get 'items/new'
    get 'items/show'
    get 'items/edit'
  end
  devise_for :admins
  namespace :admin do
    root to: "homes#top"
    resources :genres, only:[:index, :create, :edit, :update]
    resources :items, except:[:destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
