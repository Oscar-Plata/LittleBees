class ProductsController < ApplicationController
  def index
    @productos = Producto.all
  end

  def show
    producto
  end

  def new
      @product = Producto.new
  end
  

  def edit
    @product = Producto.find(params[:id])
  end

  def create
    @product = Producto.new(product_params)
    if @product.save
      redirect_to products_path, notice: "El producto se creó correctamente"
    else
      flash[:alert] = "Error al crear el producto"
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if producto.update(product_params)
      redirect_to products_path, notice: 'El producto se actualizo correctamente'
    else
      flash[:alert] = "Error al editar el producto"
      render :edit, status: :unprocessable_entity
    end
  
  end
  
  def  destroy
    if producto.destroy
      redirect_to products_path, notice: 'El producto se elimino correctamente'
    else
      flash[:alert] = "Error al eliminar el producto"
      render :edit, status: :unprocessable_entity
    end
  end
  
  
  

  private 
    def product_params
      params.require(:producto).permit(:nombre,:descripcion,:precio)
    end
    
    def producto
      @producto= Producto.find(params[:id])
    end
end
