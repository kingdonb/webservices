require "webservices/version"
require 'rails/generators'

module Webservices

    class ApiController < ActionController::Base
        
        protect_from_forgery
        #skip_before_action :verify_authenticity_token
        
        # Call the authenticate method on each request to the API
        before_filter :authenticate
        
=begin
         # global exception handler.  let no exception bubble up this far!
         rescue_from Exception do |e|
         global_exception_handler(e)
         end
         rescue_from Errors::ApiAuthorizationError, with: :api_key_not_authorized
         rescue_from Errors::MethodUsageExceeded, with: :method_usage_exceeded
         rescue_from Errors::NoMetricFound, with: :no_metric_found
         rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
=end
        private
        
        def authenticate
            # authenticate with 3scale, but only if we don't have
            # a cached copy of this exact kind of request from that api key.
            # cache lasts 5 minutes.
            cache_key = params.flatten.join("")
            Services::Caching.smart_fetch( cache_key, :expires_in => 5.minutes ) do
                #@threescale_client = Services::Threescale.new
                Services::Threescale.authenticate( params, ENV['THREESCALE_SERVICE_ID'] )  # conditionally change service ID based on authZ vs eforms API calls
            end
        end
        
        
        # EXCEPTION HANDLERS CAN PROBABLY GO ELSEWHERE....
        def global_exception_handler( e )
            if ( Rails.env == 'development' )
                show_error( e.message.to_s, 500 )
                else
                show_error( "Unhandled exception occurred", 500 )
            end
        end
        
        # see: http://guides.rubyonrails.org/layouts_and_rendering.html#options-for-render
        def record_not_found
            show_error( "Record not found", :not_found )
        end
        
        def api_key_not_authorized
            show_error( "API key not authorized", :unauthorized )
        end
        
        def no_metric_found
            show_error( "3scale metric not found", :unauthorized )
        end
        
        def method_usage_exceeded
            show_error( "Method usage limit exceeded or no access allowed", :unauthorized )
        end
        # END EXCEPTION HANDLERS
        
        # RESPONSE METHODS
        def show_success
            show_response("result", "success", :ok)
        end
        
        def show_error( message, status )
            show_response("error", message, status)
        end
        
        private
        def show_response( type, message, status )
            status ||= 200
            msg = { type => message }
            respond_to do |format|
                format.xml  { render xml: msg, status: status }
                format.json  { render json: msg, status: status }
                format.html  { render json: msg, status: status }
            end
        end
        
    end

    class WebservicesOLD
        
        # a gem to easily integrate web services into apps
        # this will allow other apps with an appropriate api key to request data from the app
        
        def self.hi
            puts "Hello world!"
        end
    
    end

end

class WebservicesInitializerGenerator < Rails::Generators::Base
    
    desc "This generator creates an webservices initializer file at config/initializers"
    
    def create_initializer_file
        create_file "config/initializers/webservices.rb", "# Add initialization content here"
    end
    
end

class WebserviceGenerator < Rails::Generators::NamedBase
    
    #template source
    #source_root File.expand_path("../templates", __FILE__)
    
    desc "This generator creates the components for a webservice app/api/component_type/webservice_name.rb"
    
    def create_initializer_file
        
        camelized_file_name = file_name.camelize
        
        controller_content = "class Api::#{camelized_file_name}Controller < Webservices::ApiController  \ndef show\n\nend\n\ndef update\n\nend\ndef index\n\nend\n\nend"
        model_content = "class Api::#{camelized_file_name} < ActiveRecord::Base\nself.table_name = \"table_name\"\nself.primary_key = \"primary_key\"\nend"
        view_content = "object @info\nattributes *#{camelized_file_name}.column_names"
        helper_content = "module Api::#{camelized_file_name}Helper\n\nend"
        
        create_file "app/controllers/api/#{file_name}_controller.rb", controller_content
        create_file "app/models/api/#{file_name}.rb", model_content
        create_file "app/helpers/api/#{file_name}_helper.rb", helper_content
        create_file "app/views/api/#{file_name}/show.rabl", view_content
        create_file "app/views/api/#{file_name}/index.rabl", view_content
        create_file "app/views/api/#{file_name}/update.rabl", view_content
    end
    
end
