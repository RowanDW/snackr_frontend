class SessionsController < ApplicationController
  def omniauth
    auth_hash = request.env['omniauth.auth']
    email = auth_hash['info']['email']
    name = auth_hash['info']['name']
    access_token = auth_hash['credentials']['token']
    response = BackendFacade.login_user(email, name, access_token)
    session[:user_id] = response
    session[:name] = name
    redirect_to '/dashboard'
  end
end
