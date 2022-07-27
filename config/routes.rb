Rails.application.routes.draw do
  resources :pair_messages
  resources :user_connections
  resources :user_pairs
  resources :channel_users
  resources :channel_messages
  resources :users
  resources :channels

  get "/users/search/:username", to: "users#search"
  post "/users/add_friend", to: "users#add_friend"
  get "/users/:id/messages/:username", to: "users#user_messages"
  post "/users/friends/send_message", to: "users#send_message"
  post "/users/channels/send_message", to: "users#channels_send_message"

  post "/login", to: "users#login"
  post "/signup", to: "users#signup"

  get "/channels/search/:username", to: "channels#search"
  post "/channels/join", to: "channels#join"
  get "/channels/:channelName/messages", to: "channels#messages"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
