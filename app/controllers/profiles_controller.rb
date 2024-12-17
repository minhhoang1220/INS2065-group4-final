class ProfilesController < InheritedResources::Base
  before_action :set_profile, only: %i[show edit update destroy]
  before_action :authenticate_user!
  before_action :correct_user, only: %i[edit update destroy]
  
  def correct_user
    @profile = current_user.profile
    redirect_to root_path, alert: "Not authorized" if @profile.nil?
  end

  private

    def profile_params
      params.require(:profile).permit(:user_id, :first_name, :last_name, :bio, :phone)
    end

end
