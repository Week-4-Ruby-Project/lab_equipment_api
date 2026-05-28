class Api::V1::MaintenanceRecordsController < Api::V1::ApiController
  # GET /api/v1/equipment/:equipment_id/maintenance_records
  def index
    @equipment = Equipment.find(params[:equipment_id])
    render json: @equipment.maintenance_records
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Equipment not found" }, status: :not_found
  end

  # POST /api/v1/equipment/:equipment_id/maintenance_records
  def create
    @equipment = Equipment.find(params[:equipment_id])
    @maintenance_record = @equipment.maintenance_records.build(maintenance_params)

    if @maintenance_record.save
      render json: @maintenance_record, status: :created
    else
      render json: { errors: @maintenance_record.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Equipment not found" }, status: :not_found
  end

  private

  def maintenance_params
    params.require(:maintenance_record).permit(:description, :performed_at)
  end
end