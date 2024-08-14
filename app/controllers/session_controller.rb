class SessionController < ApplicationController
  skip_before_action :protect_pages
  def login
  end

  def auth
    pp params[:login]
    @usuario= Usuario.find_by("correo = :login", { login: params[:login].downcase.strip})
    if @usuario&.authenticate(params[:password])
      session[:usuario_id]=@usuario.id
      redirect_to root_path, notice: "Sesion Iniciada"
    else
      redirect_to login_session_path, notice: "Credenciales Incorrectas"
    end
  end

  def logout
    session.delete(:usuario_id)
    redirect_to login_session_path, notice: "Sesion Cerrada."
  end

  def register
    @usuario=Usuario.new
  end

  
end
