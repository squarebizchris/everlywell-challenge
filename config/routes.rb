Rails.application.routes.draw do
  get 'members/new'
  get 'members/show'

  # TODO add exclusions for un used routes
  resources :members

  get 'site/index'
  root 'site#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
