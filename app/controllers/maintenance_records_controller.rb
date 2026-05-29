class MaintenanceRecordsController < ApplicationController
    before_action :set_maintenance_record, only: [:show, :update, :destroy] # [cite: 110]
  
    # GET /maintenance_records
    def index
      # Order by performed_at descending and optimize with includes to avoid N+1 [cite: 106, 160]
      @maintenance_records = MaintenanceRecord.includes(:equipment).order(performed_at: :desc)
      
      # Support ?equipment_id= filter [cite: 106, 113]
      if params[:equipment_id].present?
        @maintenance_records = @maintenance_records.where(equipment_id: params[:equipment_id])
      end
  
      # Include equipment name in the JSON response 
      render json: @maintenance_records.as_json(include: { equipment: { only: :name } })
    end
  
    # GET /maintenance_records/:id
    def show
      # Include equipment name in show response [cite: 107]
      render json: @maintenance_record.as_json(include: { equipment: { only: :name } })
    end
  
    # POST /maintenance_records
    def create
      @maintenance_record = MaintenanceRecord.new(maintenance_record_params)
      if @maintenance_record.save
        render json: @maintenance_record, status: :created # 
      else
        render json: { errors: @maintenance_record.errors.full_messages }, status: :unprocessable_entity # [cite: 48, 115]
      end
    end
  
    # PATCH/PUT /maintenance_records/:id
    def update
      if @maintenance_record.update(maintenance_record_params)
        render json: @maintenance_record, status: :ok # 
      else
        render json: { errors: @maintenance_record.errors.full_messages }, status: :unprocessable_entity # 
      end
    end
  
    # DELETE /maintenance_records/:id
    def destroy
      @maintenance_record.destroy
      head :no_content # 
    end
  
    private
  
    def set_maintenance_record
      @maintenance_record = MaintenanceRecord.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Maintenance record not found" }, status: :not_found # [cite: 48, 52]
    end
  
    def maintenance_record_params
      # Strong parameters [cite: 111]
      params.require(:maintenance_record).permit(:description, :performed_at, :equipment_id)
    end
  end 
