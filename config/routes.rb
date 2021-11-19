Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :customers, controllers: {
    sessions: 'customers/sessions',
    registrations: 'customers/registrations'
  }

  scope module: 'customers' do
    root 'items#top'
    resources :items, only: [:show, :index]
    get 'about' => 'items#about'
   end

  namespace :customers do
    resources :genres, only: [:show]
    patch 'customers/withdraw' => 'customers#withdraw', as: 'customers_withdraw'
    get 'show' => 'customers#show'
    get 'customers/edit' => 'customers#edit'
    patch 'update' => 'customers#update'
    get 'orders/about' => 'orders#about', as: 'orders_about'
    resources :orders, only: [:create, :new, :index, :show]
    resources :cart_items, only: [:index, :create, :update, :destroy]
    delete 'cart_items' => 'cart_items#all_destroy', as: 'all_destroy'
    resources :deliveries, only: [:index, :create, :destroy, :edit, :update]
  end

  # admin側ルーティング
  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
    registrations: 'admins/registrations'
  }

  namespace :admins do
    root :to => 'top#top'
    resources :customers, only: [:index, :edit, :update, :show]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :items, only: [:show, :index, :new, :create, :edit, :update]
    resources :orders, only: [:index, :show, :update]
    resources :order_details, only: [:update]
  end
  
end
