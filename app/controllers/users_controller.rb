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
    @password = params[:password]
    @passwordconf = params[:confirm_password]
    
    if(@password.eql? @passwordconf)
      @params ={ "email" => params[:email].downcase, "password" => @password,
                "name" => params[:name], "line1" => params[:address_line_1],
                "line2" => params[:address_line_2] ,
                "postcode" => params[:postcode], "state" => params[:state]}
      @register = RestClient.post "https://citsciapp.herokuapp.com/register",
              @params.to_json, {content_type: :json, accept: :json}
      @json = JSON.parse(@register)
      
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
    @approve = RestClient.post ("https://citsciapp.herokuapp.com/requests/update"),
        @params.to_json, {content_type: :json, accept: :json}
    @approve = JSON.parse(@approve)
    
    @approve['kitcodes'].each do |kitcode|
      
    end
    
  end
  
  
  
  private
  
    def user_params
      params.require(:user).permit(:name,:email,:password,
                                   :password_confirmation)
    end
    
    
end
