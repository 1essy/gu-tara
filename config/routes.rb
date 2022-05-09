Rails.application.routes.draw do


  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
}

  devise_for :admin, controllers: {
    sessions: "admin/sessions"
}

  devise_scope :customer do
    post 'customers/guest_sign_in', to: 'sessions#guest_sign_in'
  end

  namespace :admin do
    resources :customers, only: [:index, :show, :edit, :update]
    resources :rests, only: [:index, :show, :destroy] do
      resources :rest_comments, only: [:destroy]
    end
  end


  #public
  root :to => "public/homes#top"
  scope module: :public do
    get 'homes/about' => "public/homes#about"
    get "customers/:id/withdrawal_confirm" => "customers#withdrawal_confirm", as: "withdrawal_confirm"
    patch "customers/:id/withdrawal" => "customers#withdrawal",as: "withdrawal"
    resources :rests, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
      resource :favorites, only: [:create, :destroy]
      resources :rest_comments, only: [:create, :destroy]
    end
    resources :customers, only: [:index, :show, :edit, :update]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
