class SwipesController < ApplicationController
  before_action :set_swipe, only: %i[ show edit update destroy ]

  # GET /swipes or /swipes.json
  def index
    @swipes = Swipe.all
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_swipe
      @swipe = Swipe.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def swipe_params
      params.require(:swipe).permit(:SwiperUserID, :SwipedUserID, :SwipeType, :SwipeTimestamp)
    end
end
