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
  
  
  
  private
  
    def user_params
      params.require(:user).permit(:name,:email,:password,
                                   :password_confirmation)
    end
    
    
end
