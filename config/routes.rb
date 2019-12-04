Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'shelters#index'
  get '/shelters', to: 'shelters#index'
  get '/shelters/new', to: 'shelters#new'
  post '/shelters', to: 'shelters#create'
  get '/shelters/:id', to: 'shelters#show'
  get '/shelters/:id/edit', to: 'shelters#edit'
  patch '/shelters/:id', to: 'shelters#update'
  delete '/shelters/:id', to: 'shelters#destroy'

  get '/pets', to: 'pets#index'
  get '/pets/:id', to: 'pets#show'
  get '/shelters/:id/pets', to: 'pets#list_by_shelter'
  post '/shelters/:id/pets', to:'pets#create'
  get '/shelters/:id/pets/new', to: 'pets#new'
  get 'pets/:id/edit', to: 'pets#edit'
  patch 'pets/:id', to: 'pets#update'
  delete '/pets/:id', to:'pets#destroy'


  get '/favorites', to:'favorites#index'
  patch '/favorites/:id', to:'favorites#update'

  get '/shelters/:id/reviews/new', to:'reviews#new'
  post '/shelters/:id/reviews', to: 'reviews#create'
  get '/shelters/:id/reviews/edit', to: 'reviews#edit'




end
