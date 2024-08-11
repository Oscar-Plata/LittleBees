class SalesController < ApplicationController
  def index
    @sales = Venta.all
  end


  def create
    @sale = Venta.new(params[:sale])
    # if @sale.save
    #   flash[:success] = "Venta Realizada"
    #   redirect_to @sale
    # else
    #   flash[:error] = "Something went wrong"
    #   render 'new'
    # end
  end
  
end
