class Api::CLASSNAMEController < Webservices::ApiController
    
    def show

        @info = params

        respond_to do |format|
            format.json { render :json => @info }
        end

    end

    def update

        @info = params

        respond_to do |format|
            format.json { render :json => @info }
        end

    end

    def index

        @info = params
        
        respond_to do |format|
            format.json { render :json => @info }
        end

    end

end