    # webservices
    scope '/', :defaults => { :format => 'json' } do
        namespace :api do
            
            # list routes
            get #{file_name}, to: '#{file_name}#index'
            get #{file_name}/:id, to: '#{file_name}#show'
            
        end
    end