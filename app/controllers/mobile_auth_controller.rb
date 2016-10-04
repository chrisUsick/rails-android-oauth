require 'google-id-token'
require 'json'
class MobileAuthController < ApplicationController
  def sign_in
    p params
    token = params[:token]

    response = HTTParty.get("https://www.googleapis.com/oauth2/v3/tokeninfo?id_token=#{token}")

    audience = '389793287458-htdmbk821o3lfpidt7ert8vc0rn0kc29.apps.googleusercontent.com'
    if response.code == 200
      p response.body
      data = JSON.parse response.body
      raise StandardError.new('no audience') unless data['aud'] == audience
      user = User.find_for_verified_token_response data.symbolize_keys
      headers = user.create_new_auth_token
      response.headers.merge! headers
      render json: user
    else
      p response.code
    end

  end
end
