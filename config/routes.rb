NewBlockCity::Application.routes.draw do
  devise_for :users

  namespace :api do
    resources :worlds do
      resources :regions
    end

    resources :blocks
    resources :panda_videos do
      collection do
        post :callback
      end
    end
  end

  namespace :admin do
    resources :blocks
    resources :panda_videos
  end

  resources :partials, only: :show

  # Explicitly mount Jasminerice above global match rule to prevent trumping of jasmine
  mount Jasminerice::Engine => "/jasmine" if Rails.env.development? || Rails.env.test?
  match '/' => 'spine#index'
  match '/boroughs/(*other)' => 'spine#index'
  match '/regions/(*other)' => 'spine#index'
end
