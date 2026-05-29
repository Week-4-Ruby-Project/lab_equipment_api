class Api::V1::EquipmentController < Api::V1::ApiController
  # GET /api/v1/equipment
  def index
    @equipment = Equipment.all
    render json: @equipment
  end

  # GET /api/v1/equipment/:id
  def show
    @equipment = Equipment.find(params[:id])
    render json: @equipment
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Equipment not found" }, status: :not_found
  end

  # POST /api/v1/equipment
  def create
    @equipment = Equipment.new(equipment_params)
    if @equipment.save
      render json: @equipment, status: :created
    else
      render json: { errors: @equipment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def equipment_params
    params.require(:equipment).permit(:name, :serial_number, :status, :category_id)
  end
end