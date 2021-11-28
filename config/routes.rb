Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :space_probes, only: %i[index create] do
    collection do
      get '/:id/position', to: 'space_probes#show'
      put '/:id/initial_position', to: 'space_probes#reset'
      put '/:id/move', to: 'space_probes#move'
    end
  end
end
