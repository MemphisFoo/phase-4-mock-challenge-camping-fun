class ActivitiesController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :error_message
    def index
        activity = Activity.all
        render json: activity, status: :ok
    end

    def destroy
        activity = find_activity
        activity.destroy
        head :no_content
    end

    private
    def find_activity
        Activity.find(params[:id])
    end

    def error_message
        render json: {error: "Activity not found"}, status: :not_found
    end
end
