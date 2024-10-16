module WalletValidation
  extend ActiveSupport::Concern

  ALLOWED_WALLETABLE_TYPES = %w[User Stock Team].freeze
  ALLOWED_TRANSACTION_TYPES = %w[credit debit].freeze

  included do
    before_action :validate_walletable_params, only: [:create]
  end

  private

  def validate_walletable_params
    return unless validate_walletable_type
    return unless validate_transaction_type
    return unless validate_walletable_id
  end

  def validate_walletable_type
    unless ALLOWED_WALLETABLE_TYPES.include?(params[:walletable_type])
      render_invalid("Invalid walletable type. Allowed types are: #{ALLOWED_WALLETABLE_TYPES.join(', ')}.")
      return false
    end
    true
  end

  def validate_transaction_type
    if params[:transaction_type].blank? || !ALLOWED_TRANSACTION_TYPES.include?(params[:transaction_type])
      render_invalid("Invalid transaction type. Allowed types are: #{ALLOWED_TRANSACTION_TYPES.join(', ')}.")
      return false
    end
    true
  end

  def validate_walletable_id
    walletable_id = params[:walletable_id]
    if walletable_id.blank?
      render_invalid("walletable id cannot be empty.")
      return false
    elsif !valid_walletable_id?(params[:walletable_type], walletable_id)
      render_invalid("Invalid walletable id for the given walletable type.")
      return false
    end
    true
  end

  def render_invalid(message)
    render_json(status: :bad_request, message: message)
  end

  def valid_walletable_id?(walletable_type, walletable_id)
    walletable_type.constantize.exists?(walletable_id)
  rescue NameError
    false
  end
end
