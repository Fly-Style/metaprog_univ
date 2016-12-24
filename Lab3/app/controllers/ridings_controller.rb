class RidingsController < ApplicationController
  before_action :set_riding, only: [:show, :edit, :update, :destroy]

  # GET /ridings
  # GET /ridings.json
  def index
    @ridings = Riding.all
  end

  # GET /ridings/1
  # GET /ridings/1.json
  def show
  end

  # GET /ridings/new
  def new
    @riding = Riding.new
  end

  # GET /ridings/1/edit
  def edit
  end

  # POST /ridings
  # POST /ridings.json
  def create
    @riding = Riding.new(riding_params)

    respond_to do |format|
      if @riding.save
        format.html { redirect_to @riding, notice: 'Riding was successfully created.' }
        format.json { render :show, status: :created, location: @riding }
      else
        format.html { render :new }
        format.json { render json: @riding.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ridings/1
  # PATCH/PUT /ridings/1.json
  def update
    respond_to do |format|
      if @riding.update(riding_params)
        format.html { redirect_to @riding, notice: 'Riding was successfully updated.' }
        format.json { render :show, status: :ok, location: @riding }
      else
        format.html { render :edit }
        format.json { render json: @riding.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ridings/1
  # DELETE /ridings/1.json
  def destroy
    @riding.destroy
    respond_to do |format|
      format.html { redirect_to ridings_url, notice: 'Riding was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_riding
      @riding = Riding.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def riding_params
      params.require(:riding).permit(:name, :first, :second, :winner, :visible, :active)
    end
end
