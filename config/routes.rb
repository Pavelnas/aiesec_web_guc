Rails.application.routes.draw do
  devise_scope :user do
    post '/users/sign_in', to: 'password#create'
    get '/users' , to: 'user#index' , as:'user_index'
    get '/users/sign_in', to:'password#new'
    get 'users/sign_up',to:'sign_up#new'
  end
  devise_for :users
  get 'controls/login'
  root "user#index"
  resources :factions
  resources :members
  resources :ogvs
  resources :controls
  resources :myep
  resources :dash_board
  resources :user
  get '/eps/display', to:'dash_board#display', as:'ep_display'
  get '/eps/display/openSource', to: 'dash_board#openSource', as:'openSource_display'
  get '/eps/countries' , to: 'dash_board#countries' , as:'countries'

  match ':controller(/:action(/:id))' , :via => [:get , :post]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
