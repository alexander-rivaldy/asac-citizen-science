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
        if(session[:admin])
            @admin = true
        end
        
        @params = {"token" => session[:token], "refresh_token" => session[:refresh_token]}
        @sample = RestClient.post ("https://citsciapp.herokuapp.com/sample/" + params['id'].to_s),
            @params.to_json, {content_type: :json, accept: :json}
        @sample = JSON.parse(@sample)
        @data = @sample['data']
        @chemicals = @sample['data']['chemicals']
       
        
        @sampleMass = 
            JSON.parse(@data['sampleMass'].tr(':','"').tr('=>','":'))
        @conductivityAt25C = 
            JSON.parse(@data['conductivityAt25C'].tr(':','"').tr('=>','":'))
        @bicarbonateAlkalinityHCO3 = 
            JSON.parse(@data['bicarbonateAlkalinityHCO3'].tr(':','"').tr('=>','":'))
        @carbonateAlkalinityCO3 = 
            JSON.parse(@data['carbonateAlkalinityCO3'].tr(':','"').tr('=>','":'))
        @totalAlkalinityCaCO3 = 
            JSON.parse(@data['totalAlkalinityCaCO3'].tr(':','"').tr('=>','":'))
        
        
        
        @qrcode = RQRCode::QRCode.new(request.original_url)
        # With default options specified explicitly
        @png = @qrcode.as_png(
                  resize_gte_to: false,
                  resize_exactly_to: false,
                  fill: 'white',
                  color: 'black',
                  size: 120,
                  border_modules: 4,
                  module_px_size: 6,
                  file: nil # path to write
                  )
        
    end
    
    def map 
        if(session[:token].nil?)
           
            redirect_to login_path
             flash[:danger] = "YOU ARE NOT LOGGED IN"
        end
       
        if(session[:admin])
            @params = {"token" => session[:token], "refresh_token" => session[:refresh_token]}
            @locations = RestClient.post 'https://citsciapp.herokuapp.com/samples', 
                @params.to_json, {content_type: :json, accept: :json}
            @locations = JSON.parse(@locations)
        else
            @params = {"token" => session[:token], "refresh_token" => session[:refresh_token]}
            @locations = RestClient.post 'https://citsciapp.herokuapp.com/samples', 
                @params.to_json, {content_type: :json, accept: :json}
            @locations = JSON.parse(@locations)
        end
        
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
        # not implemented yet
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
