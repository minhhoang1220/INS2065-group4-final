class UsertablesController < ApplicationController
  before_action :set_usertable, only: %i[ show edit update destroy ]

  # GET /usertables or /usertables.json
  def index
    @usertables = Usertable.all
  end

  # GET /usertables/1 or /usertables/1.json
  def show
  end

  # GET /usertables/new
  def new
    @usertable = Usertable.new
  end

  # GET /usertables/1/edit
  def edit
  end

  # POST /usertables or /usertables.json
  def create
    @usertable = Usertable.new(usertable_params)

    respond_to do |format|
      if @usertable.save
        format.html { redirect_to usertable_url(@usertable), notice: "Usertable was successfully created." }
        format.json { render :show, status: :created, location: @usertable }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @usertable.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /usertables/1 or /usertables/1.json
  def update
    respond_to do |format|
      if @usertable.update(usertable_params)
        format.html { redirect_to usertable_url(@usertable), notice: "Usertable was successfully updated." }
        format.json { render :show, status: :ok, location: @usertable }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @usertable.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /usertables/1 or /usertables/1.json
  def destroy
    @usertable.destroy

    respond_to do |format|
      format.html { redirect_to usertables_url, notice: "Usertable was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def index
    @usertables = Usertable.search(params[:term])
  end  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_usertable
      @usertable = Usertable.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def usertable_params
      params.require(:usertable).permit(:TypeMem, :name, :email, :password, :active, :age, :gender, :image, :bio)
    end
end
