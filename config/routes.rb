Rails.application.routes.draw do
  namespace :api do
   namespace :v1 do
     get 'forecast', to: 'forecasts#show'
     get 'background', to: 'backgrounds#show'
     get 'munchies', to: 'munchies#show'
     post 'users', to: 'users#create'
     post 'sessions', to: 'sessions#create'
>>>>>>> e56fedf5270b4df5d7b834e021105ee1557d131a
   end
 end
end
