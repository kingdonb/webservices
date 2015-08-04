module Webservices

    class ModelAccess
        
        def model_index(model, params)
            
            output = {'data' => [], 'curr_page' => 1, 'num_per_page' => 5, 'total_pages' => 1}
            
            data = model.all
            
            if ( params.has_key?("app_name") )
                raise TypeError unless Services::Validation.isValidParameter('key', params['app_name'], '^[A-Za-z0-9\s\_]*$')
                
                app_id = Application.where('name' => params["app_name"].to_s).first.id.to_i
                data = data.where('app_id' => app_id)
                
                else
                raise ArgumentError
            end
            
            if ( params.has_key?("id") )
                
                raise TypeError unless Services::Validation.isValidParameter('key', params["id"])
                data = data.where('id' => params["id"])
                
            end
            
            total_records = data.size
            
            if (params.has_key?("num_per_page") && params.has_key?("curr_page"))
                data = data.limit(params['num_per_page']).offset((params['curr_page'].to_i-1)*params['num_per_page'].to_i)
            end
            
            output = {'data' => data, 'curr_page' => params['curr_page'], 'num_per_page' => params['num_per_page'], 'total_records' => total_records}
            
        end
        
    end

end