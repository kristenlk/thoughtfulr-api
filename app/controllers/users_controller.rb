class UsersController < ApplicationController
  skip_before_action :authenticate, only: [:login, :create]

  def login
    credentials = login_params

    token = User.login(credentials[:email], credentials[:password])

    if token
      render json: User.find_by(token: token), serializer: UserLoginSerializer
    else
      head :bad_request
    end
  end

  def show
    render json: User.find(params[:id])
  end

  def create
    @user = User.new(register_params)
    @user.profile = Profile.new(profile_params)

    if @user.save
      render json: @user, status: :created, serializer: UserLoginSerializer
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    @user = User.find(params[:id])
    @user.profile = Profile.find(params[:id])

    if @user.update(register_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    # @user.destroy

    # head :no_content
  end

  private

  def login_params
    params.require(:credentials).permit(:email, :password)
  end

  def profile_params
    params.require(:profile).permit(:moniker, :location, :email_or_phone, :selected_time, :phone_number)
  end

  def register_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
