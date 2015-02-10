# Webservices

The purpose of this gem is to provide generic web services via the 3scale services.  Simply add this gem to your gemfile and you can offer authorized or non-authorized web service calls.  This is an early version with enhancements to come.

## Installation

Add this line to your application's Gemfile:

    gem 'webservices', :git => 'https://github.com/rdelossa/webservices.git'

If you have any issues using the gem from the repo follow these directions:

https://github.com/bundler/bundler/blob/master/ISSUES.md

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install webservices

## Usage

Best to test in a clean project via: 
    rails new test_app

1. Add to GemFile:
gem 'webservices', :git => 'https://github.com/rdelossa/webservices.git'

2. Create the initializer (by default the API Authorization is disabled in the initializer):
rails generate webservices_initializer
/initializers/webservices.rb

3. Create a web service scaffold:
rails generate webservice web_service_name
(controllers/models/views...)/api/...

4. Routes
For now you have to edit routes.rb file by hand.  Insert the following into the routes.rb and add any new routes into the api namespace after creating it above.  Add any new routes to the :api namespace.

    scope '/', :defaults => { :format => 'json' } do
        namespace :api do
            get 'web_service_name/:id', to: 'web_service_name#show', as: :get_web_service_name
        end
    end

5. Demo Web Call
curl http://127.0.0.1:3000/api/web_service_name/10
This returns the input parameters from the request to confirm the web service route exists.


## Contributing

1. Fork it ( http://github.com/<my-github-username>/webservices/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
