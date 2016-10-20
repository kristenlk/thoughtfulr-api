Rails.application.routes.draw do
  post '/login' => 'users#login'
  get 'users/:id/profile', to: 'profiles#show'
  patch 'users/:id/profile', to: 'profiles#update'
  get '/received_messages', to: 'messages#received_messages'
  get '/sent_messages', to: 'messages#sent_messages'

  resources :users, except: [:new, :edit]
  resources :messages, except: [:new, :edit]
  resources :profiles, except: [:new, :edit]
end
