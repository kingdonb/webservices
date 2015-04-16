

    # webservices
    scope '/', :defaults => { :format => 'json' } do
        namespace :api do
            
            # list routes
            get 'ROUTE_NAME', to: 'ROUTE_NAME#index'
            get 'ROUTE_NAME/:id', to: 'ROUTE_NAME#show'
            
        end
    end


