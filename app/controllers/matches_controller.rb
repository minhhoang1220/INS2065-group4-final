class MatchesController < ApplicationController
  before_action :set_match, only: %i[ show edit update destroy ]

  # GET /matches or /matches.json
  def index
    if current_user.usertable.present?
      if params[:term]
        @matches = Match.search(params[:term])
      else
        @matches = Match.get_user_matches(current_user.usertable.id)
      end
      @matched_profiles = @matches.map { |match| match.get_other_profile(current_user.usertable.id) }
    else
      redirect_to new_usertable_path, alert: "Please create a profile first."
    end
    @matched_profiles ||= []
  end

  # GET /matches/1 or /matches/1.json
  def show
    @other_profile = @match.get_other_profile(current_user.usertable.id)
  end

  # GET /matches/new
  def new
    @match = Match.new
  end

  # GET /matches/1/edit
  def edit
  end

  # POST /matches or /matches.json
  def create
    @match = Match.new(match_params)

    respond_to do |format|
      if @match.save
        format.html { redirect_to match_url(@match), notice: "Match was successfully created." }
        format.json { render :show, status: :created, location: @match }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @match.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /matches/1 or /matches/1.json
  def update
    respond_to do |format|
      if @match.update(match_params)
        format.html { redirect_to match_url(@match), notice: "Match was successfully updated." }
        format.json { render :show, status: :ok, location: @match }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @match.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /matches/1 or /matches/1.json
  def destroy
    @match.destroy

    respond_to do |format|
      format.html { redirect_to matches_url, notice: "Match was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_match
      @match = Match.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def match_params
      params.require(:match).permit(:User1ID, :User2ID, :MatchTimestamp)
    end
end
