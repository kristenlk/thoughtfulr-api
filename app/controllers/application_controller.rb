class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  include ::ActionController::Serialization

  before_action :authenticate

  private

  attr_reader :current_user

  # this is the "everything is protected" step

  def authenticate
    authenticate_or_request_with_http_token do |token, options|
      # checks for the header - if it doesn't exist, ends. if it does exist, passes it to the block. If the block doesn't find the user, returns nil and 401 unauthorized. If a user exists with the token
      @current_user = User.find_by token: token
    end
  end

end
