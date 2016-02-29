Rails.application.routes.draw do
  
  get '/main' => 'users#index'
  post '/user/create' => 'users#create'
  post '/user/create_returning_user' => 'users#create_returning_user'
  get '/professional_profile' => 'users#show'
  get '/users' => 'users#show_users'
  get '/users/:id' => 'users#profile'
  post '/pending/:id' => 'users#create_pending'
  post '/accept/:id' => 'users#create_friendship'
  post '/destroy/:id' => 'users#destroy_invite'

  delete '/user/session' => 'users#delete_session'

end
