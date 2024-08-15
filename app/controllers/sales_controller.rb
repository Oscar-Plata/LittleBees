class SalesController < ApplicationController
  before_action :set_current_sale, only: [:add]
  before_action :get_current_sale, only: [:create, :commit, :remove, :cancel]
  before_action :get_products

  # FUCNION PARA EL CATALOGO DE VENTAS
  def index
    @sales = Venta.all
  end

  def show
    @sale = venta
    pp venta
    if venta.productosventa
      venta.productosventa.each do |pv|
        pp "ID_PV #{pv.id}, pro_id #{pv.producto_id}, nombre #{Producto.find(pv.producto_id).nom},  cantidad #{pv.cantidad}"
      end
    end
  end

  #FUNCION PARA EL CHECKOUT
  def create
    @sale = Current.sale
  end

  def commit
    pp "REALIZANDO VENTA"
    pp params
    if Current.sale.present?
      if Current.sale.update(fecha: Date.today, hora: Time.current.strftime("%H:%M:%S"), total: Current.sale.calcTotal)
        pp "Venta realizada"
        session.delete(:venta_id)
        Current.sale = nil
        flash[:notice] = "Venta Realizada"
      else
        flash[:alert] = "Error al realizar la venta"
      end
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace('venta', partial: 'sales/venta', locals: { sale: Current.sale }) }
      end
    else
      pp "No hay venta actual"
    end
  end

  def add
    pp "AGREGANDO PRODUCTO"
    pp params
    sale_params = params.permit(:venta_id, :id, :cantidad, :authenticity_token, :commit)
    @item = Producto.find_by(id: sale_params[:id])
    cantidad = sale_params[:cantidad].to_i
  
    if @item
      listaProductos = Current.sale.productosventa.find_by(producto_id: @item.id)
      if listaProductos && cantidad > 0
        listaProductos.update(cantidad: cantidad)
        
      elsif cantidad > 0
        Current.sale.productosventa.create(producto: @item, cantidad: cantidad)
      elsif listaProductos
        listaProductos.destroy
      end
      Current.sale.reload
        @sale = Current.sale # Asigna @sale correctamente
        respond_to do |format|
          format.turbo_stream do
            render turbo_stream: turbo_stream.replace('venta', partial: 'sales/venta', locals: { sale: @sale })
          end
        end
    else
      flash[:error] = "Producto no encontrado"
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace('venta', partial: 'sales/venta', locals: { sale: Current.sale }) }
      end
    end
  end


  def remove
    pp "ELIMINANDO PRODUCTO"
    pp params
    producto_venta = ProductoVenta.find_by(id: params[:id])
    
    if producto_venta&.destroy
      Current.sale.reload
        @sale = Current.sale # Asigna @sale correctamente
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('venta', partial: 'sales/venta')
        end
      end
    else
      flash[:error] = "Producto no encontrado"
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace('venta', partial: 'sales/venta', locals: { sale: Current.sale }) }
      end
    end
  end
  def cancel
    if Current.sale.present?
      if Current.sale.productosventa.destroy_all && Current.sale.destroy
        session.delete(:venta_id)
        flash[:notice] = "Venta cancelada exitosamente."
        respond_to do |format|
          format.turbo_stream do
            render turbo_stream: turbo_stream.replace('venta', partial: 'sales/venta')
          end
        end
      end
    end
  end
  
  

  
  private
  def venta
    @venta= Venta.find(params[:id])
  end
  
  def set_current_sale
    if session[:venta_id].present?
      Current.sale ||= Venta.find_by(id: session[:venta_id])
      pp "VENTA ACTUAL"
      pp Current.sale
    end

    if Current.sale.nil?
      Current.sale = Venta.create
      session[:venta_id] = Current.sale.id
      pp "VENTA NUEVA"
    end
  end

  def get_current_sale
    if session[:venta_id].present?
      Current.sale ||= Venta.find_by(id: session[:venta_id])
      pp "YA EXISTE UNA VENTA EN PROCESO"
      pp Current.sale
    else
      pp "NO HAY VENTA EN PROCESO"
    end
  end

  def get_products
    @catalogo = Producto.all
  end
end
