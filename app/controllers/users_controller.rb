class UsersController < ApplicationController
  skip_before_action :authenticate, only: [:login, :create]
  # below was set up by scaffold
  # before_action :set_user, only: [:show, :update, :destroy]


  # POST /login
  def login
    # credentials = user_credentials
    credentials = login_params
    # user = User.find_by email: credentials[:email]
    token = User.login(credentials[:email], credentials[:password])
    # if User.login works, there will be a token. If there is a token, render the token as json. If there is not, you're unauthorized.
    if token
      render json: User.find_by(token: token), serializer: UserLoginSerializer
    else
      head :bad_request
    end
  end

  # GET /users
  # GET /users.json
  def index
    # @users = User.all

    # render json: @users
  end

  # GET /users/1
  # GET /users/1.json
  def show
    # render json: @user
  end

  # POST /users
  # POST /users.json
  # should be able to go to localhost:3000/users/create
  def create
    @user = User.new(register_params)
    @user.profile = Profile.new(profile_params)
    #@user.profile.build(profile_params)
    # @user.profile = @profile
    # credentials = login_params
    # token = User.login(credentials[:email], credentials[:password])
    if @user.save # && @profile.save # && token
      #render json: @user, status: :created, location: @user
      render json: @user, status: :created, serializer: UserLoginSerializer
      #render json: User.find_by(token: token), serializer: UserLoginSerializer
    else
      # if !@user.valid?
        render json: @user.errors, status: :unprocessable_entity
      # else
      #   render json: @profile.errors, status: :unprocessable_entity

      # render json: @user.errors, status: :unprocessable_entity
      # render json: @profile.errors, status: :unprocessable_entity
    end
  end



  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    # @user = User.find(params[:id])

    # if @user.update(user_params)
    #   head :no_content
    # else
    #   render json: @user.errors, status: :unprocessable_entity
    # end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    # @user.destroy

    # head :no_content
  end

  private

  def login_params
    params.require(:credentials).permit(:email, :password)
  end

  def profile_params
    params.require(:profile).permit(:moniker, :location, :email_or_phone, :selected_time)
  end

  def register_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
    # def user_credentials
    #   params.require(:credentials).permit(:email, :password, :password_confirmation)
    # end

    # def set_user
    #   @user = User.find(params[:id])
    # end

    # def user_params
    #   params.require(:user).permit(:email, :password, :password_confirmation)
    # end
end
