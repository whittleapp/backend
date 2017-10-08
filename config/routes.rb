Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :businesses, only: [:index, :update]

  get '/advance_time', to: 'presentations#advance_time'
  get '/reset_time', to: 'presentations#reset_time'
end
