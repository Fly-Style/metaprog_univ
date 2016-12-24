class BetToRidesController < ApplicationController
  before_action :set_bet_to_ride, only: [:show, :edit, :update, :destroy]

  # GET /bet_to_rides
  # GET /bet_to_rides.json
  def index
    @bet_to_rides = BetToRide.all
  end

  # GET /bet_to_rides/1
  # GET /bet_to_rides/1.json
  def show
  end

  # GET /bet_to_rides/new
  def new
    @bet_to_ride = BetToRide.new
  end

  # GET /bet_to_rides/1/edit
  def edit
  end

  # POST /bet_to_rides
  # POST /bet_to_rides.json
  def create
    @bet_to_ride = BetToRide.new(bet_to_ride_params)

    respond_to do |format|
      if @bet_to_ride.save
        format.html { redirect_to @bet_to_ride, notice: 'Bet to ride was successfully created.' }
        format.json { render :show, status: :created, location: @bet_to_ride }
      else
        format.html { render :new }
        format.json { render json: @bet_to_ride.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bet_to_rides/1
  # PATCH/PUT /bet_to_rides/1.json
  def update
    respond_to do |format|
      if @bet_to_ride.update(bet_to_ride_params)
        format.html { redirect_to @bet_to_ride, notice: 'Bet to ride was successfully updated.' }
        format.json { render :show, status: :ok, location: @bet_to_ride }
      else
        format.html { render :edit }
        format.json { render json: @bet_to_ride.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bet_to_rides/1
  # DELETE /bet_to_rides/1.json
  def destroy
    @bet_to_ride.destroy
    respond_to do |format|
      format.html { redirect_to bet_to_rides_url, notice: 'Bet to ride was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bet_to_ride
      @bet_to_ride = BetToRide.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bet_to_ride_params
      params.require(:bet_to_ride).permit(:bet_winner, :success, :riding_id, :bet_id)
    end
end
