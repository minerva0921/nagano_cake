Rails.application.routes.draw do
  # devise_for :admin, :controllers => {
  #   :sessions => 'admin/sessions',
  #   :registrations => 'admin/registrations',
  # }
  devise_for :admin, controllers: {
    sessions: 'admin/sessions',
    registrations: 'admin/registrations',
  }

  namespace :admin do
    root 'homes#top'
    resources :customers,only: [:index,:show,:edit,:update]
  	resources :items,only: [:index,:new,:create,:show,:edit,:update,]
  	resources :genres,only: [:index,:create,:edit,:update, :show]
  	resources :orders,only: [:index,:show,:update] do
  	  member do
        get :current_index
        resource :order_details,only: [:update]
      end
      collection do
        get :today_order_index
      end
    end
  end

  # customer
  devise_for :customers, :controllers => {
    :sessions => 'public/customers/sessions',
    :registrations => 'public/customers/registrations',
    :passwords => 'public/customers/passwords'
  }

  get 'about' => 'public/homes#about'
  root 'public/homes#top'
  
  scope module: :public do
    resources :items,only: [:index,:show]
    get 'edit/customers' => 'customers#edit'
    patch 'update/customers' => 'customers#update'
    
  	resource :customers,only: [:edit,:update,:show] do
  		collection do
  	     get 'quit'
  	     patch 'out'
  	  end
  	end

      resources :cart_items,only: [:index,:update,:create,:destroy] do
        collection do
          delete '/' => 'cart_items#all_destroy'
        end
      end

      resources :orders,only: [:new,:index,:show,:create] do
        collection do
          post 'confirm'
          get 'thanks'
        end
      end

      resources :addresses,only: [:index,:create,:edit,:update,:destroy]
    end

end
