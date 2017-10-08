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
        if(session[:token].nil?)
           
            redirect_to login_path
             flash[:danger] = "YOU ARE NOT LOGGED IN"
        end
       
        @params = {"token" => session[:token], "refresh_token" => session[:refresh_token]}
        @sample = RestClient.post ("https://citsciapp.herokuapp.com/sample/" + params['id'].to_s),
            @params.to_json, {content_type: :json, accept: :json}
        @sample = JSON.parse(@sample)
        @data = @sample['data']
        @chemicals = @sample['data']['chemicals']
    end
    
    def map 
        if(session[:token].nil?)
           
            redirect_to login_path
             flash[:danger] = "YOU ARE NOT LOGGED IN"
        end
       
        
        @params = {"token" => session[:token], "refresh_token" => session[:refresh_token]}
        @locations = RestClient.post 'https://citsciapp.herokuapp.com/samples', 
            @params.to_json, {content_type: :json, accept: :json}
        @locations = JSON.parse(@locations)
        
        gon.locations = @locations
    end
    
    def list
        if(session[:token].nil?)
           
            redirect_to login_path
             flash[:danger] = "YOU ARE NOT LOGGED IN"
        end
       
        
        @params = {"token" => session[:token], "refresh_token" => session[:refresh_token]}
        @locations = RestClient.post 'https://citsciapp.herokuapp.com/samples', 
            @params.to_json, {content_type: :json, accept: :json}
        @locations = JSON.parse(@locations)
        
        gon.locations = @locations
    end
    
    def grid
        if(session[:token].nil?)
           
            redirect_to login_path
             flash[:danger] = "YOU ARE NOT LOGGED IN"
        end
       
        
        @params = {"token" => session[:token], "refresh_token" => session[:refresh_token]}
        @locations = RestClient.post 'https://citsciapp.herokuapp.com/samples', 
            @params.to_json, {content_type: :json, accept: :json}
        @locations = JSON.parse(@locations)
        
        gon.locations = @locations
    end
    
    def edit
        if(session[:token].nil?)
           
            redirect_to login_path
             flash[:danger] = "YOU ARE NOT LOGGED IN"
        end
        if(session[:admin].nil?)
           
           flash[:danger] = "YOU ARE NOT AN ADMIN"
           redirect_to profile_path
             
        end
       
       
        @params = {"token" => session[:token], "refresh_token" => session[:refresh_token]}
        @sample = RestClient.post ("https://citsciapp.herokuapp.com/sample/" + params['id'].to_s),
            @params.to_json, {content_type: :json, accept: :json}
        @sample = JSON.parse(@sample)
        
        @data = @sample['data']
        @chemicals = @sample['data']['chemicals']
        
    end
    
    def update
        @params = {"token" => session[:token], "refresh_token" => session[:refresh_token]}
        @sample = RestClient.post ("https://citsciapp.herokuapp.com/sample/" + params['id'].to_s),
            @params.to_json, {content_type: :json, accept: :json}
        @sample = JSON.parse(@sample)
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
