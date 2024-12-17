class MembershipsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin, except: [:index]

  # GET /memberships or /memberships.json
  def index
    @memberships = Membership.all
  end

  private

  def check_admin
    redirect_to root_path, alert: "You are not authorized to perform this action." unless current_user.admin?
  end

  def membership_params
    params.require(:membership).permit(:TypeMem, :price, :description)
  end
end