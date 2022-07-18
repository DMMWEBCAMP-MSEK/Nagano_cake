Rails.application.routes.draw do

  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

  scope module: :public do
    root to: "homes#top"
    get "homes/about"

    resources :items, only: [:show, :index]
    resource :customers, only: [:index, :edit], path_names: { edit: 'information/edit' } do
      get "/my_page" => "customers#show"
      patch "/information" => "customers#update"
      get "confirm"
      patch "withdraw"
    end


    resources :cart_items, only: [:index, :update, :destroy, :create] do
      collection do
        delete "/destroy_all" => "cart_items#destroy_all"
      end
    end

    resources :orders, only: [:new, :create, :index, :show] do
      collection do
      post "confirm"
      get "thanks"
      end
    end

    resources :shipping_addresses, only: [:index, :edit, :create, :update, :destroy]
  end

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

  namespace :admin do
    root to: "homes#top"
    resources :items, only: [:new, :show, :index, :edit, :create, :update]
    resources :genres, only: [:index, :edit, :create, :update]
    resources :customers, only: [:show, :index, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :order_items, only: [:update]
    #delete "items#destroy"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
