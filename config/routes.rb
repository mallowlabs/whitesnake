Whitesnake::Application.routes.draw do
  root to: 'top#show'

  get '/login' => redirect('/auth/github'), :as => :login

  resource :user, only: [ :show ]

  resources :repositories, only: [], id: %r[[^/]+/[^/]+] do
    resource :job, only: [ :create, :show, :destroy ]
  end

  controller :sessions do
    get '/auth/:provider/callback' => :create
    get '/auth/failure' => :failure
    get '/logout' => :destroy, as: :logout
  end
end
