module RenderResponse
  extend ActiveSupport::Concern

  STATUS_MESSAGES = {
    ok: "Success",
    created: "Transaction successful Created",
    bad_request: "Bad Request",
    forbidden: "Permission Denied",
    too_many_requests: "Resource Exhausted",
    internal_server_error: "Internal Server Error",
    service_unavailable: "Service Unavailable",
    gateway_timeout: "Gateway Timeout",
    unprocessable_entity: "Unprocessable Entity",
    unauthorized: "Invalid email or password"
  }.freeze

  def render_json(status: :ok, message: nil, data: {}, errors: nil)
    response_body = { message: message || STATUS_MESSAGES[status], data: data }
    response_body[:errors] = errors if errors.present?
    render json: response_body, status: status
  end

  def handle_exception(exception, status: :internal_server_error)
    render_json(status: status, errors: [exception.message])
  end
end
