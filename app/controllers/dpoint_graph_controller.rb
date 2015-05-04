class DpointGraphController < ApplicationController
#  create_table "dpoints", force: :cascade do |t|
#    t.string   "timestamp"
#    t.string   "app_name"
#    t.string   "pipeline_id"
#    t.string   "pipeline_instance_id"
#    t.string   "sabre_phase"
#    t.string   "task"
#    t.string   "trended_metrics"
#    t.string   "tags"
#    t.datetime "created_at",           null: false
#    t.datetime "updated_at",           null: false
#  end
# dpoint.elapsed gives elapsed time (in seconds) from #begin to #end if dpoint is #end (otherwise nil)
# dpoint.phase_elapsed gives elapsed time (in seconds) from first dpoint to dpoint in a sabre_phase

  def index
    uuid = params[:uuid]
    @dpoints = Dpoint.by_uuid(uuid)

  end

  def data
    uuid = params[:uuid]
    @dpoints = Dpoint.by_uuid(uuid)

    respond_to do |format|
      format.json {
#        render :json => [1,2,3,4,5]
# convert dpoints to simpler id, timestamp, sabre_phase, task, elapsed, phase_elapsed
        render json: @dpoints
      }
    end
  end
end
