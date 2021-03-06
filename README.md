# Webservices

The purpose of this gem is to provide generic web services via the 3scale services.  Simply add this gem to your gemfile and you can offer authorized or non-authorized web service calls.  This is an early version with enhancements to come.

## Installation

Add this line to your application's Gemfile:

    gem 'webservices', :git => 'https://github.com/rdelossa/webservices.git'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install webservices

If you have any issues using the gem from the repo follow these directions:

https://github.com/bundler/bundler/blob/master/ISSUES.md

## Usage

<h4>Start a new app to test this gem</h4>

    $ rails new test_app

Move into the newly created app folder

    $ cd test_app

Following the installation directions above.

<h4>Create the initializer</h4>
By default the API Authorization is disabled in the initializer.
    
    $ rails generate webservices_initializer

Edit /initializers/webservices.rb to enable/disable API Authorization and assign the proper service_id and provider key information.

<h4>Create a web service scaffold</h4>
    
    $ rails generate webservice web_service_name

This creates the appropriate files in app/controllers/api, app/helpers/api, app/models/api and app/views/api.  This is done to keep the web services files separate from the rest of the app.

<h4>Routes</h4>

The following will be inserted into /config/routes.rb for each new api added.

    scope '/', :defaults => { :format => 'json' } do
        namespace :api do
            get 'web_service_name/:id', to: 'web_service_name#show', as: :get_web_service_name
        end
    end


<h4>Model Access</h4>

To get an index listing of a specific model use the following command:

    model_index_object = Webservices::ModelAccess.model_index(MODEL_NAME, params)

Where params could looke like: 

    {app_name = APP_NAME, 'curr_page' => 1, 'num_per_page' => 5}

or

    {app_name = APP_NAME, 'id' => 123456}.

For a specific record.

The returned data will look like:

    {"data"=>[], "curr_page"=>CURR_PAGE, "num_per_page"=>NUM_PER_PAGE, "total_records"=>TOTAL_RECORDS} 

NOTE: The pagination information is optional.

<h4>Demo Web Call</h4>

Run test_app locally and call the web services via the following call to confirm that the route is working. 

    curl http://127.0.0.1:3000/api/web_service_name/10

This returns the input parameters from the request to confirm the web service route exists.

## Bonus

This class method will present all the available api calls:

    Webservices::RouteRecognizer.new.api_routes

This can be used to create a web service call that shows all the available routes.

The code was adapted from a modified version of http://coryforsyth.com/2013/06/02/programmatically-list-routespaths-from-inside-your-rails-app/

## Contributing

The basis of this gem was code created by Brandon Rich.

1. Fork it ( http://github.com/<my-github-username>/webservices/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
