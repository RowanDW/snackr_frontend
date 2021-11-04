class SessionsController < ApplicationController

  def create
    auth_hash = request.env['omniauth.auth']
    email = auth_hash['info']['email']
    name = auth_hash['info']['name']
    token = auth_hash['credentials']['token']
    # response =  BackendService.register_user(email, name, token)
    # session[:user_id] = response[:data][:id]
    # session[:name] = name
    redirect_to '/dashboard'
  end
end
