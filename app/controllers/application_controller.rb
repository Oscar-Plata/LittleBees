class ApplicationController < ActionController::Base
 before_action :set_current_user
 before_action :protect_pages
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  private
  def set_current_user
    Current.user = Usuario.find_by(id: session[:usuario_id]) if session[:usuario_id]
  end

  def protect_pages
    redirect_to login_session_path, alert: "Necesitas iniciar sesion para acceder a este sitio!" unless Current.user
  end
end
