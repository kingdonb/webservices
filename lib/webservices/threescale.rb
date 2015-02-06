module Webservices
class Threescale


  # You only need to instantiate a new Client once and store it as a global variable
  # You should store your provider key in the environment because this key is secret!
  #def create_client(service_id)
  #  @threescale_service_id = service_id #ENV['THREESCALE_SERVICE_ID']
  #  @@threescale_client ||= ThreeScale::Client.new(:provider_key => ENV['THREESCALE_PROVIDER_KEY'])
  #end

  # To record usage, create a new metric in your application plan. You will use the
  # "system name" that you specifed on the metric/method to pass in as the key to the usage hash.
  # The key needs to be a symbol.
  # A way to pass the metric is to add a parameter that will pass the name of the metric/method along
  def self.authenticate( params, service_id )
    #start = Time.now
    
    client = ThreeScale::Client.new(:provider_key => ENV['THREESCALE_PROVIDER_KEY'])
    
    # usage metrics are reported to 3scale.
    # controls reporting and RATE LIMITING.
    response = client.authrep(:user_key => params["api_key"],
                                     :service_id => service_id,
                                     :usage => { :hits => 1, Threescale.metric_name(params) => 1})

    #finish = Time.now
    #Rails.logger.debug( "\n\n3scale elapsed: " + (finish-start).to_s + "\n\n" )

    puts "Response"
    puts response.to_json

    if response.success?
      return true
      # All fine, the usage will be reported automatically. Proceeed.
    else

      case response.error_code
      when "user_key_invalid"
        raise Errors::ApiAuthorizationError
      when "metric_invalid"
        raise Errors::NoMetricFound
      else
        if response.error_message == "usage limits are exceeded"
          raise Errors::MethodUsageExceeded
        else
          raise Exception
        end
      end

    end

  end

  def self.metric_name( params )
      
    puts params.to_json
    metric_name = params[:controller] + "/" + params[:action]
    puts "metric_name: " + metric_name
    metric_name

  end


end

end
