class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :omniauthable
  include DeviseTokenAuth::Concerns::User
  def self.find_for_verified_token_response(auth)
    user = User.where(:provider => "google_oauth2", :uid => auth[:sub]).first

    unless user
      user = User.new(:name => auth[:name],
                         :email => auth[:email],
                         :provider => "google_oauth2",
                         :uid => auth[:sub])
      user.save validate: false
    end

    user
  end
end
