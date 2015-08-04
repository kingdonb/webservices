module Webservices

class Validation
    
    def self.isValidParameter (key, value, criteria = '^[a-zA-Z0-9]*$')
    
        flag = false
        
        if Regexp.new(criteria) === value
        
            flag = true
        
        end

        flag
    
    end

end

end
