class SamplesController < ApplicationController
   def new
        @sample = Sample.new
    end
    
    def create
        @sample = Sample.create(samples_params) # Not the final implementation!
        if @sample.save
            flash[:success] = "Sample successfully added"
            render 'new'
        else
            render 'new'
        end
    end
    
    def show
       @sample = Sample.find(params[:id]) 
       
       
    end
    
    def map 
        @params = {"email" => "bugs@rubyplus.com", "password" => "123456"}
        
        @login = RestClient.post "https://citsciapp.herokuapp.com/login",
           @params.to_json, {content_type: :json, accept: :json}
        @json = JSON.parse(@login)
        
        @params = {"token" => @json["token"], "refresh_token" => @json["refresh_token"]}
        @locations = RestClient.post 'https://citsciapp.herokuapp.com/samples', 
            @params.to_json, {content_type: :json, accept: :json}
        @locations = JSON.parse(@locations)
        
        gon.locations = @locations
    end
  
  private
        def samples_params
          params.require(:sample).permit(:name, :lat, :lat_type, :lon, :lon_type,
                :taken, :description, :mass, :fluidmass, :fluidmassrecovered, 
                :ph, :conductivity, :bicarbonate_alkalinity, :carbonate_alkalinity,
                :total_alkalinity, :sulphate, :fluoride, :calcium, :magnesium,
                :sodium, :potassium, :silver, :aluminium, :arsenic, :barium)
        end
    
end
