class DpointsController < ApplicationController
  before_action :set_dpoint, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' }

  # GET /dpoints
  # GET /dpoints.json
  def index
    if (params[:firehose] == "true")
      @dpoints = Dpoint.all
    else
      @dpoints = Dpoint.page(params[:page])
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render xml: @dpoints}
      format.json { render json: @dpoints}
    end
  end

  # GET /dpoints/1
  # GET /dpoints/1.json
  def show
  end

  # GET /dpoints/new
  def new
    @dpoint = Dpoint.new
  end

  # GET /dpoints/1/edit
  def edit
  end

  # POST /dpoints
  # POST /dpoints.json
  def create
    @dpoint = Dpoint.new(dpoint_params)

    respond_to do |format|
      if @dpoint.save
        format.html { redirect_to @dpoint, notice: 'Dpoint was successfully created.' }
        format.json { render :show, status: :created, location: @dpoint }
      else
        format.html { render :new }
        format.json { render json: @dpoint.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dpoints/1
  # PATCH/PUT /dpoints/1.json
  def update
    respond_to do |format|
      if @dpoint.update(dpoint_params)
        format.html { redirect_to @dpoint, notice: 'Dpoint was successfully updated.' }
        format.json { render :show, status: :ok, location: @dpoint }
      else
        format.html { render :edit }
        format.json { render json: @dpoint.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dpoints/1
  # DELETE /dpoints/1.json
  def destroy
    @dpoint.destroy
    respond_to do |format|
      format.html { redirect_to dpoints_url, notice: 'Dpoint was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dpoint
      @dpoint = Dpoint.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dpoint_params
      params.require(:dpoint).permit(:timestamp, :app_name, :pipeline_id, :pipeline_instance_id, :sabre_phase, :task, :trended_metrics, :tags)
    end
end
