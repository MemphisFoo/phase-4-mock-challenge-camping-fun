class SignupsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
    # def index
    #     camper=Signup.all
    #     render json: camper, status: :ok
    # end

    # def show
    #    camper=find_camper 
    #    activities=camper.activities
    #    render json: activities, include: :camper
    # end

    def create
       camper=Signup.create!(signup_params)
       render json:camper.activity, status: :created
    end

    private

    # def find_camper
    #     Camper.find(params[:id])
    # end

    def signup_params
        params.permit(:camper_id, :activity_id, :time)
    end

    def render_unprocessable_entity_response(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end
end

