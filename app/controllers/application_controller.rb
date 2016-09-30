class ApplicationController < ActionController::Base
  before_action :default_format_json
  before_action :authenticate!
  include DeviseTokenAuth::Concerns::SetUserByToken

  def authenticate!
    authenticate_user! unless params['controller'] == 'devise_token_auth/sessions'
  end

  private
  def default_format_json
    request.format = "json"
  end
end
