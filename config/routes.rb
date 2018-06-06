Rails.application.routes.draw do
  root 'fleet_calculator#show'

  resources :ships

  get 'fleet_calculator/show', to: 'fleet_calculator#show'
  get 'fleet_calculator/calculate', to: 'fleet_calculator#weight_calculate'
end
