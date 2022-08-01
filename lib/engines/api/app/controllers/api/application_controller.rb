module Api
  class ApplicationController < ActionController::API
    # TODO authenticate with e.g authenticate_or_request_with_http_token
    # or just token_and_options to extract and verify the token
    include ActionController::HttpAuthentication::Token
    after_action :log_response
    
    def render_success(message, result=nil, status: :ok)
      render json: { message: message, result: result }, status: status
    end  
    
    def render_failure(message, errors = [], status: :internal_server_error)
      render json: { message: message, errors: errors }, status: status
    end  
    
    rescue_from(ActionController::ParameterMissing) do |ex|
      error = {}
      error[ex.param] = ['parameter is required']
      render_failure("Parameter is missing.", [error], status: :unprocessable_entity)
    end  
    
    rescue_from(ActionController::UnpermittedParameters) do |ex|
      error = {}
      ex.params.each { |param| error[param] = ['parameter is not permitted'] }
      render_failure("Found unpermitted parameters.", [error], status: :unprocessable_entity)
    end
    
    rescue_from(ActiveRecord::RecordNotFound) do |ex|
      render_failure("#{ex.model} is not found.", status: :not_found)
    end
    
    def log_response
      Rails.logger.info("API response: #{response.body}")
    end  
  end
end
