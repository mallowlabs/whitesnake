Whitesnake::Application.routes.draw do
  get "users/show"
  get "top/show"
  get '/auth/:provider/callback' => 'sessions#create'
  get '/auth/failure' => 'sessions#failure'
  get '/logout' => 'sessions#destroy', as: :logout
end
