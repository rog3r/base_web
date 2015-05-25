BaseWeb::Application.routes.draw do
  devise_for :users
  resources :users
  resources :roles do
    collection do
      get :edit_multiple
      put :update_multiple
    end
  end

  get 'dashboard', to: 'dashboard#index'

  root to: 'dashboard#index'
end
