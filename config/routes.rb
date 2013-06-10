Whitesnake::Application.routes.draw do
  root to: 'top#show'

  resource :user, only: [ :show ]

  get '/auth/:provider/callback' => 'sessions#create'
  get '/auth/failure' => 'sessions#failure'
  get '/logout' => 'sessions#destroy', as: :logout
end
