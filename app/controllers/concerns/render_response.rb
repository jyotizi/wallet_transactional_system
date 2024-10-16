module RenderResponse
  extend ActiveSupport::Concern

  STATUS_MESSAGES = {
    ok: "Success",
    bad_request: "Bad Request",
    forbidden: "Permission Denied",
    too_many_requests: "Resource Exhausted",
    internal_server_error: "Internal Server Error",
    service_unavailable: "Service Unavailable",
    gateway_timeout: "Gateway Timeout"
  }.freeze

  def render_response(status: :ok, message: nil, data: {}, errors: nil)
    render json: { message: message || STATUS_MESSAGES[status], data: data.presence, errors: errors.presence }, status: status
  end

  def handle_exception(exception, status: :internal_server_error)
    render_response(status: status, errors: [exception.message])
  end
end
