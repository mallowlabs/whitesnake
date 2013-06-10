Whitesnake::Application.routes.draw do
  root to: 'top#show'

  resource :user, only: [ :show ]

  controller :sessions do
    get '/auth/:provider/callback' => :create
    get '/auth/failure' => :failure
    get '/logout' => :destroy, as: :logout
  end
end
