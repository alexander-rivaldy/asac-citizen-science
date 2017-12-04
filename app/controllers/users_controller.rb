class UsersController < ApplicationController
  
  def show
    @params = {"token" => session[:token], "refresh_token" => session[:refresh_token]}
    @user = RestClient.post ("https://citsciapp.herokuapp.com/profile"),
        @params.to_json, {content_type: :json, accept: :json}
    @user = JSON.parse(@user)
    
    @params = {"token" => session[:token], "refresh_token" => session[:refresh_token]}
    @sample = RestClient.post 'https://citsciapp.herokuapp.com/samples', 
        @params.to_json, {content_type: :json, accept: :json}
    @sample = JSON.parse(@sample)
    
    @numsamples = @sample['data'].count
    
  end
   
  def edit
    if(session[:token].nil?)
           
        redirect_to login_path
         flash[:danger] = "YOU ARE NOT LOGGED IN"
    end
    @params = {"token" => session[:token], "refresh_token" => session[:refresh_token]}
    @user = RestClient.post ("https://citsciapp.herokuapp.com/profile"),
        @params.to_json, {content_type: :json, accept: :json}
    @user = JSON.parse(@user)
    @edit = ""
  end
  
  def update
    
    # API function not yet implemented
    @params = {"token" => session[:token], 
                "refresh_token" => session[:refresh_token],
                "name" => params[:name],
                "email" => params[:email]
    }
    redirect_to profile_path
    return
    @user = RestClient.post ("https://citsciapp.herokuapp.com/update"),
        @params.to_json, {content_type: :json, accept: :json}
    @user = JSON.parse(@user)
  end
  
  def editaddress
    if(session[:token].nil?)
       redirect_to login_path
       flash[:danger] = "YOU ARE NOT LOGGED IN"
    end
    @params = {"token" => session[:token], "refresh_token" => session[:refresh_token]}
    @user = RestClient.post ("https://citsciapp.herokuapp.com/profile"),
        @params.to_json, {content_type: :json, accept: :json}
    @user = JSON.parse(@user)
    @update = ""
    
  end
  
  def updateaddress
    @line1 = params[:line1]
    @line2 = params[:line2]
    @postcode = params[:postcode]
    @state = params[:state]
    
    @params = {"token" => session[:token], 
                "refresh_token" => session[:refresh_token],
                "line1" => params[:line1],
                "line2" => params[:line2],
                "postcode" => params[:postcode],
                "state" => params[:state] }
    @register = RestClient.post "https://citsciapp.herokuapp.com/updateAddress",
            @params.to_json, {content_type: :json, accept: :json}
    redirect_to profile_path
  end
   
  def edit
    if(session[:token].nil?)
           
        redirect_to login_path
         flash[:danger] = "YOU ARE NOT LOGGED IN"
    end
    @params = {"token" => session[:token], "refresh_token" => session[:refresh_token]}
    @user = RestClient.post ("https://citsciapp.herokuapp.com/profile"),
        @params.to_json, {content_type: :json, accept: :json}
    @user = JSON.parse(@user)
    @edit = ""
  end
  
  def update
    
    # API function not yet implemented
    @params = {"token" => session[:token], 
                "refresh_token" => session[:refresh_token],
                "name" => params[:name],
                "email" => params[:email]
    }
    redirect_to profile_path
    return
    @user = RestClient.post ("https://citsciapp.herokuapp.com/update"),
        @params.to_json, {content_type: :json, accept: :json}
    @user = JSON.parse(@user)
  end
  
  def editaddress
    if(session[:token].nil?)
       redirect_to login_path
       flash[:danger] = "YOU ARE NOT LOGGED IN"
    end
    @params = {"token" => session[:token], "refresh_token" => session[:refresh_token]}
    @user = RestClient.post ("https://citsciapp.herokuapp.com/profile"),
        @params.to_json, {content_type: :json, accept: :json}
    @user = JSON.parse(@user)
    @update = ""
    
  end
  
  def updateaddress
    @line1 = params[:line1]
    @line2 = params[:line2]
    @postcode = params[:postcode]
    @state = params[:state]
    
    @params = {"token" => session[:token], 
                "refresh_token" => session[:refresh_token],
                "line1" => params[:line1],
                "line2" => params[:line2],
                "postcode" => params[:postcode],
                "state" => params[:state] }
    @register = RestClient.post "https://citsciapp.herokuapp.com/updateAddress",
            @params.to_json, {content_type: :json, accept: :json}
    redirect_to profile_path
  end
  
  def new
    @register = ""
  end
  
  def create
    @register
    @password = params[:password]
    @passwordconf = params[:password_confirmation]
    
    if(@password.eql? @passwordconf)
      @params ={ "email" => params[:email], 
                 "password" => @password,
                "name" => params[:name], 
                "streetAddress" => params[:street_address],
                "city" => params[:city] ,
                "postcode" => params[:postcode], 
                "state" => params[:state] }
      puts @params
      @register = RestClient.post ("https://citsciapp.herokuapp.com/register"),
              @params.to_json, {content_type: :json, accept: :json}
      @json = JSON.parse(@register)
      
      puts @json
      
      if(@json["status"].eql? "SUCCESS")
        flash[:success] = "Registered successfully!"
        redirect_to login_path
      else
        flash[:danger] = "Registered failed, please try again"
        render 'new'
      end
      
      
    else
      flash[:danger] = "Password and password confirmation does not match!"
      
    end
    
  end
  
  def requests
    if(session[:admin])
        @admin = true
    end
    if(!@admin)
      redirect_to profile_path
      return
    end
    @params = {"token" => session[:token], "refresh_token" => session[:refresh_token]}
    @users = RestClient.post ("https://citsciapp.herokuapp.com/requests/all"),
        @params.to_json, {content_type: :json, accept: :json}
    @users = JSON.parse(@users)
    
    @request = ""
  end
  
  def approverequest
    @params = {"token" => session[:token], 
              "refresh_token" => session[:refresh_token],
              "approved" => true,
              "request_id" => params[:request_id]
    }
    @users = RestClient.post ("https://citsciapp.herokuapp.com/requests/all"),
        @params.to_json, {content_type: :json, accept: :json}
    @users = JSON.parse(@users)
  end
  
  def requests
    if(session[:admin])
        @admin = true
    end
    if(!@admin)
      redirect_to profile_path
      return
    end
    puts session[:token]
    puts session[:refresh_token]
    @params = {"token" => session[:token], "refresh_token" => session[:refresh_token]}
    @users = RestClient.post ("https://citsciapp.herokuapp.com/requests/all"),
        @params.to_json, {content_type: :json, accept: :json}
    @users = JSON.parse(@users)
    
    puts session[:token]
    
    @request = ""
  end
  
  def approverequest
    @params = {"token" => session[:token], 
              "refresh_token" => session[:refresh_token],
              "approved" => "true",
              "request_id" => params[:request_id]
    }
    @approve = RestClient.post ("https://citsciapp.herokuapp.com/requests/update"),
        @params.to_json, {content_type: :json, accept: :json}
    @approve = JSON.parse(@approve)
    
    puts session[:token]
    puts session[:refresh_token]
    puts @approve
    
    @kits = []
    
    @approve['kitcodes'].each do |kitcode|
      
      @qrcode = RQRCode::QRCode.new(kitcode)
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
      @kits.push([@png, kitcode])
      puts kitcode
    end
    puts @kits
    
  end
  def deleterequest
    puts "test"
    @params = {"token" => session[:token], 
              "refresh_token" => session[:refresh_token],
              "approved" => "false",
              "request_id" => params[:id]
    }
    @delete = RestClient.post ("https://citsciapp.herokuapp.com/requests/update"),
        @params.to_json, {content_type: :json, accept: :json}
    @delete = JSON.parse(@delete)
    redirect_to request_path
  end
  
  
  private
  
    def user_params
      params.require(:user).permit(:name,:email,:password,
                                   :password_confirmation)
    end
    
    
end
