class ProductsController < ApplicationController
  def index
    @products = Producto.all
  end

  def show
    @product= Producto.find(params[:id])
  end

  
end
