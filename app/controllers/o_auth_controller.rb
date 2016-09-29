class OAuthController < ApplicationController
  def callback
    puts request.env['omniauth.auth'].to_hash.inspect
    render json: request.env['omniauth.auth'].to_hash 
  rescue "No Data"
  end
end
