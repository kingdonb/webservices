require 'webservices'

# Add initialization content here

Webservices::SERVICE_ID = ENV['SERVICE_ID']
Webservices::PROVIDER_KEY = ENV['PROVIDER_KEY']

if Rails.env.development?
    Webservices::BYPASS_API_AUTHENTICATION = true
elsif Rails.env.test?
    Webservices::BYPASS_API_AUTHENTICATION = false
else
    Webservices::BYPASS_API_AUTHENTICATION = false
end
