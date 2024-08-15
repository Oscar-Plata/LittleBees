class ProductsController < ApplicationController
  def index
    @productos = Producto.with_attached_foto.order(nombre: :asc)
    if params[:busqueda].present?
      busqueda= params[:busqueda]
      # @productos = @productos.where("MATCH(nombre, descripcion) AGAINST(?) OR id= ?", busqueda,busqueda.to_i)
  
      busqueda= params[:busqueda]
      if busqueda.to_i.to_s == busqueda
        @productos = @productos.where("id = ?", busqueda.to_i)
      else
        @productos = @productos.where("nombre LIKE ? OR descripcion LIKE ?", "%#{busqueda}%", "%#{busqueda}%")
      end
    end
  end

  def show
    producto
  end

  def new
      @producto = Producto.new
  end
  
  def edit
    producto
  end

  def create
    @producto = Producto.new(product_params)
    if @producto.save
      redirect_to productos_path, notice: "El producto se creó correctamente"
    else
      flash[:alert] = "Error al crear el producto"
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if producto.update(product_params)
      redirect_to productos_path, notice: 'El producto se actualizó correctamente'
    else
      flash[:alert] = "Error al editar el producto"
      render :edit, status: :unprocessable_entity
    end
  
  end
  
  def destroy
    if producto.productosventa.exists?
      flash[:alert] = "No se puede eliminar el producto porque está asociado a una venta"
      redirect_to productos_path, status: :see_other
    elsif producto.destroy
      redirect_to productos_path, notice: 'El producto se eliminó correctamente', status: :see_other
    else
      flash[:alert] = "Error al eliminar el producto"
      render :edit, status: :unprocessable_entity
    end
  end

  def search
    query = params[:query]
    pp query
    @productos = Producto.all.where('nombre LIKE ?', "%#{query}%")

    pp @productos

    respond_to do |format|
      format.html { render partial: 'products/resultados', locals: { productos: @productos } }
      # format.json { render json: @productos }
    end
  end

  private 
    def product_params
      params.require(:producto).permit(:nombre,:descripcion,:precio,:foto)
    end
    
    def producto
      @producto= Producto.find(params[:id])
    end
end
