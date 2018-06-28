Rails.application.routes.draw do
  get 'members/new'
  get 'members/show'

  resources :members
  post '/make_friendship' => 'members#make_friendship', as: :make_friendship

  get 'site/index'
  root 'site#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
