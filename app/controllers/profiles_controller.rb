class ProfilesController < ApplicationController
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

  def profile_params
    params.require(:profile).permit(:moniker, :location, :opted_in, :email_or_phone, :selected_time, :phone_number)
  end
end
