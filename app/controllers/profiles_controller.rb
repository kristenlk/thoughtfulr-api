class ProfilesController < ApplicationController

# show number of received messages / number of sent messages / moniker / location / time of day / phone or email / phone / opt in or opt out

  def show
    render json: Profile.find(params[:id])
  end

  def update
    profile = Profile.find(params[:id])
    if profile.update(profile_params)
      render json: profile
    else
      render json: profile.errors, status: :unprocessable_entity
    end
  end

# edit moniker / location / time of day / phone or email / phone / opt in or opt out

  def profile_params
    params.require(:profile).permit(:moniker, :location, :opted_in, :email_or_phone, :selected_time, :phone_number)
  end

end
