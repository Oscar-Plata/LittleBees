class UsersController < ApplicationController
  skip_before_action :protect_pages, only: [:create,:new]

  def index
    @usuarios = Usuario.all
  end

  def show
    usuario
  end

  def new
    @usuario = Usuario.new
  end

  def edit
    usuario
  end

  def create
    @usuario = Usuario.new(user_params)
    if @usuario.save
      if request.referer.include?("register")
        redirect_to login_session_path, notice: "Registro exitoso. Ahora puedes iniciar sesión."
      else
        redirect_to usuarios_path, notice: "El usuario se creó correctamente"
      end
    else
      if request.referer.include?("register")
        redirect_to register_session_path, notice: "Registro fallido.Vuelve a intentarlo."
      else
        flash[:alert] = "Error al crear el usuario"
        render :new, status: :unprocessable_entity
      end
    end
  end

  def update
      if usuario.update(user_params)
        redirect_to usuarios_path, notice: "El usuario se actualizó correctamente"
      else
        flash[:alert] = "Error al actualizar el usuario"
        render :new, status: :unprocessable_entity
      end
  end

  def destroy
    if usuario.destroy
      redirect_to usuarios_path, notice: 'El usuario se eliminó correctamente', status: :see_other
    else
      flash[:alert] = "Error al usuario el producto"
      render :edit, status: :unprocessable_entity
    end
  end

  private 
  def user_params
    params.require(:usuario).permit(:nombre,:correo,:password)
  end
  
  def usuario
    @usuario= Usuario.find(params[:id])
  end
end
