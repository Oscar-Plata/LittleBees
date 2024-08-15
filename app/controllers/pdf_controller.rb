class PdfController < ApplicationController

  def download
    pdf=Prawn::Document.new
    pdf.text 'HOLA MUNDO'
    send_data(pdf.render,filename: 'hello.pdf', type: 'application/pdf')
  end
  

  def generate
    venta = Venta.find(params[:id])
    pdf=Prawn::Document.new
    pdf.text 'VENTA'
    if venta.productosventa
      venta.productosventa.each do |pv|
        pdf.text  "ID_PV #{pv.id}, pro_id #{pv.producto_id}, nombre #{Producto.find(pv.producto_id).nombre},  cantidad #{pv.cantidad}"
      end
    end
    send_data(pdf.render,filename: "Venta_#{venta.id}.pdf", type: 'application/pdf',disposition: 'attachment')
  end

end