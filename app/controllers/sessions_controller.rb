class SessionsController < ApplicationController
  def new
  end
  
  def create
    @params = {"email" => params[:session][:email].downcase, "password" => params[:session][:password]}
        
    @login = RestClient.post "https://citsciapp.herokuapp.com/login",
       @params.to_json, {content_type: :json, accept: :json}
    @json = JSON.parse(@login)
    
    if(@json["status"].eql? "FAIL")
      flash[:danger] = 'Invalid email/password combination'
      render 'new'
    else
      session[:token] = @json["token"]
      session[:refresh_token] = @json["refresh_token"]
      session[:name] = @json["name"]
      redirect_to map_path
    end
    
    
  end
  
  def destroy
    session.delete(:token)
  end
end
