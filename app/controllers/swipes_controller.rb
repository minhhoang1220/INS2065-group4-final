class SwipesController < ApplicationController
  before_action :set_swipe, only: %i[ show edit update destroy ]

  # GET /swipes or /swipes.json
  def index
    if current_user.usertable.present?
      swiped_user_ids = Swipe.where(SwiperUserID: current_user.usertable.id).pluck(:SwipedUserID)
      @random_profile = Usertable.where.not(id: swiped_user_ids + [current_user.usertable.id]).order("RANDOM()").first
    else
      redirect_to new_usertable_path, alert: "Please create a profile first."
    end
  end

  # GET /swipes/1 or /swipes/1.json
  def show
  end

  # GET /swipes/new
  def new
    @swipe = Swipe.new
  end

  # GET /swipes/1/edit
  def edit
  end

  # POST /swipes or /swipes.json
  def create
    @swipe = Swipe.new(swipe_params)

    respond_to do |format|
      if @swipe.save
        format.html { redirect_to swipe_url(@swipe), notice: "Swipe was successfully created." }
        format.json { render :show, status: :created, location: @swipe }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @swipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /swipes/1 or /swipes/1.json
  def update
    respond_to do |format|
      if @swipe.update(swipe_params)
        format.html { redirect_to swipe_url(@swipe), notice: "Swipe was successfully updated." }
        format.json { render :show, status: :ok, location: @swipe }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @swipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /swipes/1 or /swipes/1.json
  def destroy
    @swipe.destroy

    respond_to do |format|
      format.html { redirect_to swipes_url, notice: "Swipe was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # POST /swipes/like_or_dislike
  def like_or_dislike
    @swipe = Swipe.new(swipe_params)
    @swipe.SwiperUserID = current_user.usertable.id
    @swipe.SwipeTimestamp = Time.current

    Rails.logger.debug "Swipe params: #{swipe_params.inspect}"
    Rails.logger.debug "New swipe: #{@swipe.attributes.inspect}"

    if @swipe.save
      Rails.logger.info "Swipe saved successfully"
      check_for_match(@swipe) if @swipe.SwipeType == 'like'
      redirect_to swipes_path, notice: "Swipe was successfully recorded."
    else
      Rails.logger.error "Failed to save swipe: #{@swipe.errors.full_messages}"
      redirect_to swipes_path, alert: "Failed to record swipe: #{@swipe.errors.full_messages.join(', ')}"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_swipe
      @swipe = Swipe.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def swipe_params
      params.require(:swipe).permit(:SwipedUserID, :SwipeType)
    end

    def check_for_match(swipe)
      # Kiểm tra nếu người dùng được "like" đã "like" lại người dùng hiện tại
      reciprocal_swipe = Swipe.find_by(SwiperUserID: swipe.SwipedUserID, SwipedUserID: swipe.SwiperUserID, SwipeType: 'like')
      
      if reciprocal_swipe
        Match.create(User1ID: swipe.SwiperUserID, User2ID: swipe.SwipedUserID, MatchTimestamp: Time.current)
      end
    end
end
