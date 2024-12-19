class MessagesController < ApplicationController
  before_action :set_match, only: %i[ index create ]
  before_action :authenticate_user!

  # GET /messages or /messages.json
  def index
    @matches = if params[:term]
      Match.joins(:messages)
           .where('"messages"."messageText" LIKE ?', "%#{params[:term]}%")
           .where('"matches"."User1ID" = ? OR "matches"."User2ID" = ?', 
                  current_user.usertable.id, current_user.usertable.id)
           .distinct
    else
      Match.where('"matches"."User1ID" = ? OR "matches"."User2ID" = ?', 
                  current_user.usertable.id, current_user.usertable.id)
    end

    if params[:match_id]
      @match = Match.find(params[:match_id])
      @messages = @match.messages.includes(:sender, :receiver).order('"messages"."messageTimestamp" ASC')
      @other_user = @match.get_other_profile(current_user.usertable.id)
    end
  end

  # GET /messages/1 or /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages or /messages.json
  def create
    @message = @match.messages.new(message_params.merge(
      senderID: current_user.usertable.id,
      receiverID: @match.get_other_profile(current_user.usertable.id).id,
      messageTimestamp: Time.current
    ))

    if @message.save
      redirect_to match_messages_path(@match)
    else
      redirect_to match_messages_path(@match), alert: "Message could not be sent."
    end
  end

  # PATCH/PUT /messages/1 or /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to message_url(@message), notice: "Message was successfully updated." }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1 or /messages/1.json
  def destroy
    @message.destroy

    respond_to do |format|
      format.html { redirect_to messages_url, notice: "Message was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def message_params
      params.require(:message).permit(:messageText)
    end

    def set_match
      @match = Match.find(params[:match_id]) if params[:match_id]
    end
end
