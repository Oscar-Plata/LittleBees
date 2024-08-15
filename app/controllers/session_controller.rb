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
    pp "LOGOUT"
    ##ELIMINAR POSIBLES VENTAS 
    if session[:venta_id].present?
      "HAY UNA VENTA EN PROCESO"
      Current.sale ||= Venta.find_by(id: session[:venta_id])
      pp Current.sale.productosventa.destroy_all
      pp Current.sale.destroy
    else
      pp "NO HAY VENTA EN PROCESO"
    end
    ##CERRAR SESION USUARIO
    session.delete(:usuario_id)
    session.delete(:venta_id)
    redirect_to login_session_path, notice: "Sesion Cerrada."
  end

  def register
    @usuario=Usuario.new
  end

  
end
