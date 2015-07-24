class ApplicationController < ActionController::API
  before_action :authenticate

  attr_reader :current_user

  private

  # this is the "everything is protected" step

  def authenticate
    authenticate_or_request_with_http_token do |token, options|
      # checks for the header - if it doesn't exist, ends. if it does exist, passes it to the block. If the block doesn't find the user, returns nil and 401 unauthorized. If a user exists with the token
      @current_user = User.find_by token: token
    end
  end

end
