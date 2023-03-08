class Api::V1::AlertsController < ApplicationController
    before_action :verify_request, only: %i[ create ]

    private

    def verify_request
        project_name, request_token = ::Base64.decode64(request.authorization.split(' ', 2).last || '').split(":")
        @project = Project.find_by(title: project_name)
        render json: { errors: {"request" => ["Not authenticated"]} }, status: :forbidden if !@project || @project.secret_token != request_token
    end

    def alert_params
        params.require(:alert).permit(:Type, :RecordType, :TypeCode, :Name, :Tag, :MessageStream, :Description, :Email, :From, :BouncedAt)
    end

end
