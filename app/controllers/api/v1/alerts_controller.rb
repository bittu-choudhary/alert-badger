class Api::V1::AlertsController < ApplicationController
    before_action :verify_request, only: %i[ create ]

    def create
        alert = AlertDetail.create(
            project: @project,
            name: alert_params["Name"],
            alert_type: alert_params["Type"],
            description: alert_params["Description"],
            from: alert_params["From"],
            payload: JSON.parse(alert_params.to_json))
        alert_handler = AlertHandlerService.new(alert)
        alert_handler.inspect
        render json: {status: "success"}, status: :created
    end

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
