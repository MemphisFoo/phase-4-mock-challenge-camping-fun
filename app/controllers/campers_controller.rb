class CampersController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    def index
        camper=Camper.all
        render json: camper, status: :ok
    end

    def show
       camper=find_camper 
    
       render json: camper, serializer: CampersWithActivitiesSerializer
    end

    def create
       camper=Camper.create!(camper_params)
       render json:camper, status: :created
    end

    private

    def find_camper
        Camper.find(params[:id])
    end

    def camper_params
        params.permit(:name, :age)
    end

    def record_not_found
        render json: { error: "Camper not found"}, status: :not_found
    end

    def render_unprocessable_entity_response(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end
end
