Rails.application.routes.draw do
  resources :groups, except: :show

  resources :uploads, only: %i[index create]
  
  root 'groups#index'
end
