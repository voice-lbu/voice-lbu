class AnnualMeetingsController < ApplicationController
  before_action :set_annual_meeting, only: [:show, :edit, :update, :destroy]

  # GET /annual_meetings
  # GET /annual_meetings.json
  def index
    @annual_meetings = AnnualMeeting.all
  end

  # GET /annual_meetings/1
  # GET /annual_meetings/1.json
  def show
  end

  # GET /annual_meetings/new
  def new
    @annual_meeting = AnnualMeeting.new
  end

  # GET /annual_meetings/1/edit
  def edit
  end

  # POST /annual_meetings
  # POST /annual_meetings.json
  def create
    @annual_meeting = AnnualMeeting.new(annual_meeting_params)

    respond_to do |format|
      if @annual_meeting.save
        format.html { redirect_to @annual_meeting, notice: 'Annual meeting was successfully created.' }
        format.json { render :show, status: :created, location: @annual_meeting }
      else
        format.html { render :new }
        format.json { render json: @annual_meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /annual_meetings/1
  # PATCH/PUT /annual_meetings/1.json
  def update
    respond_to do |format|
      if @annual_meeting.update(annual_meeting_params)
        format.html { redirect_to @annual_meeting, notice: 'Annual meeting was successfully updated.' }
        format.json { render :show, status: :ok, location: @annual_meeting }
      else
        format.html { render :edit }
        format.json { render json: @annual_meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /annual_meetings/1
  # DELETE /annual_meetings/1.json
  def destroy
    @annual_meeting.destroy
    respond_to do |format|
      format.html { redirect_to annual_meetings_url, notice: 'Annual meeting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_annual_meeting
      @annual_meeting = AnnualMeeting.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def annual_meeting_params
      params.require(:annual_meeting).permit(:start_at, :fee)
    end
end
